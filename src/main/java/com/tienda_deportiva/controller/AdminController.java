package com.tienda_deportiva.controller;

import com.tienda_deportiva.model.Usuario;
import com.tienda_deportiva.service.UsuarioService;
import com.tienda_deportiva.service.CategoriaService;
import com.tienda_deportiva.service.ProductoService;
import com.tienda_deportiva.service.VentaService;
import com.tienda_deportiva.service.AsistenciaService;
import com.tienda_deportiva.service.SecurityService;
import com.tienda_deportiva.model.Venta;
import com.tienda_deportiva.model.DetalleVenta;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private CategoriaService categoriaService;

    @Autowired
    private ProductoService productoService;

    @Autowired
    private VentaService ventaService;

    @Autowired
    private AsistenciaService asistenciaService;

    @Autowired
    private SecurityService securityService;

    @GetMapping("/gestion")
    public String gestion(HttpSession session, Model model, RedirectAttributes redirectAttributes,
            @RequestParam(defaultValue = "productos") String tab) {
        String validacion = securityService.validarAdmin(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        model.addAttribute("empleados", usuarioService.listarTodos());
        model.addAttribute("categorias", categoriaService.listarTodas());
        model.addAttribute("productos", productoService.listarTodos());
        model.addAttribute("ventas", ventaService.listarTodas());
        model.addAttribute("asistencias", asistenciaService.listarTodas());
        model.addAttribute("activeTab", tab);
        return "admin/gestion";
    }

    @GetMapping("/empleado-crear")
    public String mostrarFormularioCrear(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarAdmin(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        model.addAttribute("empleado", new Usuario());
        return "admin/empleado-crear";
    }

    @PostMapping("/empleado-crear")
    public String crearEmpleado(HttpSession session, @ModelAttribute Usuario usuario,
            RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarAdmin(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        // Validación DNI: exactamente 8 dígitos
        if (usuario.getDni() == null || !usuario.getDni().matches("\\d{8}")) {
            redirectAttributes.addFlashAttribute("errorEmpleado", "El DNI debe tener exactamente 8 dígitos.");
            return "redirect:/admin/empleado-crear";
        }

        usuario.setEstado(true);
        usuarioService.crearUsuario(usuario);
        return "redirect:/admin/gestion?tab=empleados";
    }

    @GetMapping("/empleado-editar/{id}")
    public String mostrarFormularioEditar(HttpSession session, @PathVariable Integer id, Model model,
            RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarAdmin(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        Usuario usuarioActual = (Usuario) session.getAttribute("usuarioActual");
        Usuario empleado = usuarioService.buscarPorId(id);

        if (empleado.getId_usuario() == 1) {
            redirectAttributes.addFlashAttribute("errorEmpleado",
                    "No se puede editar al administrador principal.");
            return "redirect:/admin/gestion?tab=empleados";
        }

        if ("Administrador".equals(empleado.getCargo()) && usuarioActual.getId_usuario() != 1) {
            redirectAttributes.addFlashAttribute("errorEmpleado",
                    "Solo el administrador principal puede editar a otros administradores.");
            return "redirect:/admin/gestion?tab=empleados";
        }

        model.addAttribute("empleado", empleado);
        return "admin/empleado-editar";
    }

    @PostMapping("/empleado-editar")
    public String editarEmpleado(HttpSession session, @ModelAttribute Usuario usuario,
            @RequestParam String estado, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarAdmin(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        Usuario usuarioActual = (Usuario) session.getAttribute("usuarioActual");
        Usuario empleadoExistente = usuarioService.buscarPorId(usuario.getId_usuario());

        if (empleadoExistente.getId_usuario() == 1) {
            redirectAttributes.addFlashAttribute("errorEmpleado",
                    "No se puede editar al administrador principal.");
            return "redirect:/admin/gestion?tab=empleados";
        }

        if ("Administrador".equals(empleadoExistente.getCargo()) && usuarioActual.getId_usuario() != 1) {
            redirectAttributes.addFlashAttribute("errorEmpleado",
                    "Solo el administrador principal puede editar a otros administradores.");
            return "redirect:/admin/gestion?tab=empleados";
        }

        if (usuario.getDni() == null || !usuario.getDni().matches("\\d{8}")) {
            redirectAttributes.addFlashAttribute("errorEmpleado", "El DNI debe tener exactamente 8 dígitos.");
            return "redirect:/admin/empleado-editar/" + usuario.getId_usuario();
        }

        usuario.setEstado(Boolean.valueOf(estado));
        usuarioService.actualizar(usuario);
        return "redirect:/admin/gestion?tab=empleados";
    }

    @GetMapping("/empleado-eliminar/{id}")
    public String eliminarEmpleado(HttpSession session, @PathVariable Integer id,
            RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarAdmin(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        Usuario usuarioActual = (Usuario) session.getAttribute("usuarioActual");
        Usuario empleado = usuarioService.buscarPorId(id);

        if (empleado.getId_usuario() == 1) {
            redirectAttributes.addFlashAttribute("errorEmpleado",
                    "No se puede eliminar al administrador principal.");
            return "redirect:/admin/gestion?tab=empleados";
        }

        if ("Administrador".equals(empleado.getCargo()) && usuarioActual.getId_usuario() != 1) {
            redirectAttributes.addFlashAttribute("errorEmpleado",
                    "Solo el administrador principal puede eliminar a otros administradores.");
            return "redirect:/admin/gestion?tab=empleados";
        }

        if (usuarioService.tieneVentasOAsistencias(id)) {
            redirectAttributes.addFlashAttribute("errorEmpleado",
                    "No se puede eliminar el empleado porque tiene ventas o asistencias registradas.");
            return "redirect:/admin/gestion?tab=empleados";
        }

        usuarioService.eliminar(id);
        redirectAttributes.addFlashAttribute("successEmpleado", "Empleado eliminado exitosamente.");
        return "redirect:/admin/gestion?tab=empleados";
    }

    @GetMapping("/perfil-admin")
    public String perfilAdmin(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarAdmin(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        Usuario usuarioActual = (Usuario) session.getAttribute("usuarioActual");
        model.addAttribute("usuario", usuarioActual);

        return "admin/perfil-admin";
    }

    @GetMapping("/venta-detalle/{id}")
    public String ventaDetalle(HttpSession session, @PathVariable Long id, Model model,
            RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarAdmin(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        Venta venta = ventaService.buscarPorId(id);
        List<DetalleVenta> detalles = ventaService.buscarDetallesPorVenta(id);

        model.addAttribute("venta", venta);
        model.addAttribute("detalles", detalles);

        return "admin/venta-detalle";
    }

    @GetMapping("/metricas")
    public String metricas(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarAdmin(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        // Obtener métricas generales para tarjetas resumen
        Map<String, Object> generales = ventaService.obtenerMetricasGenerales();
        model.addAttribute("totalVentas", generales.getOrDefault("total_ventas", 0));
        model.addAttribute("ingresosTotales", generales.getOrDefault("ingresos_totales", 0));
        model.addAttribute("productosActivos", generales.getOrDefault("productos_activos", 0));
        model.addAttribute("empleadosActivos", generales.getOrDefault("empleados_activos", 0));

        // Series solicitadas
        List<Map<String, Object>> ventasDiarias30 = ventaService.obtenerVentasDiarias30Dias();
        List<Map<String, Object>> asistenciaSemanal = ventaService.obtenerAsistenciaSemanal();
        List<Map<String, Object>> ventasPorCategoria = ventaService.obtenerVentasPorCategoria6Meses();

        model.addAttribute("ventasDiarias30", ventasDiarias30);
        model.addAttribute("asistenciaSemanal", asistenciaSemanal);
        model.addAttribute("ventasPorCategoria", ventasPorCategoria);

        // Ventas mensuales (para calcular meta mensual y ticket promedio)
        List<Map<String, Object>> ventasMensuales = ventaService.obtenerVentasMensuales();
        model.addAttribute("ventasMensuales", ventasMensuales);

        // Asistencia mensual (para el widget mensual si hay datos)
        List<Map<String, Object>> asistenciaMensual = ventaService.obtenerAsistenciaMensual();
        model.addAttribute("asistenciaMensual", asistenciaMensual);

        // Calcular cumplimiento de meta mensual (S/ 2,000) para el mes actual
        double metaMensual = 2000.0;
        LocalDate ahora = LocalDate.now(ZoneId.systemDefault());
        int mesActual = ahora.getMonthValue();
        int anioActual = ahora.getYear();
        double totalMesActual = 0.0;
        int cantidadVentasMesActual = 0;
        for (Map<String, Object> m : ventasMensuales) {
            Number mesN = (Number) m.get("mes");
            Number anioN = (Number) m.get("anio");
            if (mesN != null && anioN != null) {
                int mes = mesN.intValue();
                int anio = anioN.intValue();
                if (mes == mesActual && anio == anioActual) {
                    Number totalMes = (Number) m.get("total_mes");
                    Number cant = (Number) m.get("cant_ventas_mes");
                    totalMesActual = totalMes != null ? totalMes.doubleValue() : 0.0;
                    cantidadVentasMesActual = cant != null ? cant.intValue() : 0;
                    break;
                }
            }
        }
        boolean cumpleMeta = totalMesActual >= metaMensual;
        double ticketPromedio = cantidadVentasMesActual > 0 ? totalMesActual / cantidadVentasMesActual : 0.0;

        model.addAttribute("metaMensual", metaMensual);
        model.addAttribute("totalMesActual", totalMesActual);
        model.addAttribute("cumpleMeta", cumpleMeta);
        model.addAttribute("ticketPromedio", ticketPromedio);

        return "admin/metricas";
    }
}
