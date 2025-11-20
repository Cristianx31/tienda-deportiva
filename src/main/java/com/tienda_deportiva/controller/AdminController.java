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
    public String gestion(HttpSession session, Model model, RedirectAttributes redirectAttributes, @RequestParam(defaultValue = "productos") String tab) {
        String validacion = securityService.validarAdmin(session, redirectAttributes);
        if (validacion != null) return validacion;
        
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
        if (validacion != null) return validacion;
        
        model.addAttribute("empleado", new Usuario());
        return "admin/empleado-crear";
    }

    @PostMapping("/empleado-crear")
    public String crearEmpleado(HttpSession session, @ModelAttribute Usuario usuario, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarAdmin(session, redirectAttributes);
        if (validacion != null) return validacion;
        
        usuario.setEstado(true);
        usuarioService.crearUsuario(usuario);
        return "redirect:/admin/gestion?tab=empleados";
    }

    @GetMapping("/empleado-editar/{id}")
    public String mostrarFormularioEditar(HttpSession session, @PathVariable Integer id, Model model, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarAdmin(session, redirectAttributes);
        if (validacion != null) return validacion;
        
        model.addAttribute("empleado", usuarioService.buscarPorId(id));
        return "admin/empleado-editar";
    }

    @PostMapping("/empleado-editar")
    public String editarEmpleado(HttpSession session, @ModelAttribute Usuario usuario, 
                                 @RequestParam String estado, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarAdmin(session, redirectAttributes);
        if (validacion != null) return validacion;
        
        usuario.setEstado(Boolean.valueOf(estado));
        usuarioService.actualizar(usuario);
        return "redirect:/admin/gestion?tab=empleados";
    }

    @GetMapping("/empleado-eliminar/{id}")
    public String eliminarEmpleado(HttpSession session, @PathVariable Integer id, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarAdmin(session, redirectAttributes);
        if (validacion != null) return validacion;
        
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
        if (validacion != null) return validacion;
        
        Usuario usuarioActual = (Usuario) session.getAttribute("usuarioActual");
        model.addAttribute("usuario", usuarioActual);
        
        return "admin/perfil-admin";
    }

    @GetMapping("/venta-detalle/{id}")
    public String ventaDetalle(HttpSession session, @PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarAdmin(session, redirectAttributes);
        if (validacion != null) return validacion;
        
        Venta venta = ventaService.buscarPorId(id);
        List<DetalleVenta> detalles = ventaService.buscarDetallesPorVenta(id);
        
        model.addAttribute("venta", venta);
        model.addAttribute("detalles", detalles);
        
        return "admin/venta-detalle";
    }

    @GetMapping("/venta-anular/{id}")
    public String anularVenta(HttpSession session, @PathVariable Long id, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarAdmin(session, redirectAttributes);
        if (validacion != null) return validacion;
        
        ventaService.anularVenta(id);
        return "redirect:/admin/gestion";
    }

    @GetMapping("/metricas")
    public String metricas(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarAdmin(session, redirectAttributes);
        if (validacion != null) return validacion;
        
        Map<String, Object> metricas = ventaService.obtenerMetricasGenerales();
        model.addAttribute("totalVentas", metricas.get("total_ventas"));
        model.addAttribute("ingresosTotales", metricas.get("ingresos_totales"));
        model.addAttribute("productosActivos", metricas.get("productos_activos"));
        model.addAttribute("empleadosActivos", metricas.get("empleados_activos"));
        
        List<Map<String, Object>> ventasMensuales = ventaService.obtenerVentasMensuales();
        model.addAttribute("ventasMensuales", ventasMensuales);
        
        List<Map<String, Object>> categorias = ventaService.obtenerCategoriaMasVendidaMes();
        model.addAttribute("categoriasMes", categorias);
        
        List<Map<String, Object>> inventarioCritico = ventaService.obtenerInventarioCritico();
        model.addAttribute("inventarioCritico", inventarioCritico);
        
        Map<String, Object> asistencia = ventaService.obtenerAsistenciaEmpleados();
        model.addAttribute("asistencia", asistencia);
        
        return "admin/metricas";
    }
}
