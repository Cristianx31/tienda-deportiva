package com.tienda_deportiva.controller;

import com.tienda_deportiva.service.ProductoService;
import com.tienda_deportiva.service.CategoriaService;
import com.tienda_deportiva.service.VentaService;
import com.tienda_deportiva.service.AsistenciaService;
import com.tienda_deportiva.model.Venta;
import com.tienda_deportiva.model.DetalleVenta;
import com.tienda_deportiva.model.Asistencia;
import com.tienda_deportiva.model.Usuario;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpSession;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Controller
@RequestMapping("/vendedor")
public class VendedorController {
    
    @Autowired
    private ProductoService productoService;
    
    @Autowired
    private CategoriaService categoriaService;
    
    @Autowired
    private VentaService ventaService;

    @Autowired
    private AsistenciaService asistenciaService;
    
    @GetMapping("/index")
    public String index(HttpSession session, Model model) {
        Usuario usuarioActual = (Usuario) session.getAttribute("usuarioActual");
        if (usuarioActual != null) {
            // Obtener asistencia de hoy
            List<Asistencia> asistenciasHoy = asistenciaService.buscarPorIdUsuario(usuarioActual.getId_usuario());
            Asistencia asistenciaHoy = null;
            
            for (Asistencia a : asistenciasHoy) {
                if (a.getFecha().equals(LocalDate.now())) {
                    asistenciaHoy = a;
                    break;
                }
            }
            
            model.addAttribute("asistenciaHoy", asistenciaHoy);
        }
        return "vendedor/index";
    }

    @GetMapping("/perfil")
    public String perfilVendedor() {
        return "vendedor/perfil-vendedor";
    }
    
    @GetMapping("/catalogo")
    public String catalogo(Model model) {
        model.addAttribute("productos", productoService.listarTodos());
        model.addAttribute("categorias", categoriaService.listarTodas());
        return "vendedor/catalogo";
    }
    
    @GetMapping("/publicidad")
    public String publicidad() {
        return "vendedor/publicidad";
    }
    
    @GetMapping("/contacto")
    public String contacto() {
        return "vendedor/contacto";
    }
    
    @GetMapping("/producto-detalle/{id}")
    public String productoDetalle(@PathVariable Long id, Model model) {
        model.addAttribute("producto", productoService.buscarPorId(id));
        return "vendedor/producto-detalle";
    }

    @GetMapping("/venta")
    public String venta() {
        return "vendedor/venta";
    }

    @GetMapping("/venta-detalle")
    public String ventaDetalleTemp() {
        return "vendedor/venta-detalle";
    }

    @GetMapping("/venta-detalle/{id}")
    public String ventaDetalle(@PathVariable Long id, Model model) {
        Venta venta = ventaService.buscarPorId(id);
        List<DetalleVenta> detalles = ventaService.buscarDetallesPorVenta(id);
        
        model.addAttribute("venta", venta);
        model.addAttribute("detalles", detalles);
        
        return "vendedor/venta-detalle";
    }

    @GetMapping("/ventas-empleado")
    public String ventasEmpleado(Model model) {
        Long idUsuarioLogueado = 2L;
        List<Venta> ventasEmpleado = ventaService.listarPorUsuario(idUsuarioLogueado);
        model.addAttribute("ventas", ventasEmpleado);
        return "vendedor/ventas-empleado";
    }

    @GetMapping("/ventas")
    public String ventas(Model model) {
        model.addAttribute("ventas", ventaService.listarTodas());
        return "vendedor/ventas";
    }

    // MARCAJE DE ASISTENCIA
    @PostMapping("/marcar-entrada")
    public String marcarEntrada(HttpSession session, RedirectAttributes redirectAttributes) {
        Usuario usuarioActual = (Usuario) session.getAttribute("usuarioActual");
        
        if (usuarioActual == null) {
            return "redirect:/login";
        }

        // Verificar si ya marcó entrada hoy
        List<Asistencia> asistenciasHoy = asistenciaService.buscarPorIdUsuario(usuarioActual.getId_usuario());
        boolean yaMarcoHoy = asistenciasHoy.stream()
                .anyMatch(a -> a.getFecha().equals(LocalDate.now()));

        if (yaMarcoHoy) {
            redirectAttributes.addFlashAttribute("warning", "Ya marcaste entrada hoy");
        } else {
            Asistencia asistencia = new Asistencia();
            asistencia.setIdUsuario(usuarioActual.getId_usuario());
            asistencia.setFecha(LocalDate.now());
            asistencia.setHoraIngreso(LocalTime.now());
            asistenciaService.guardar(asistencia);
            redirectAttributes.addFlashAttribute("success", "¡Entrada marcada correctamente!");
        }

        return "redirect:/vendedor/index";
    }

    @PostMapping("/marcar-salida")
    public String marcarSalida(HttpSession session, RedirectAttributes redirectAttributes) {
        Usuario usuarioActual = (Usuario) session.getAttribute("usuarioActual");
        
        if (usuarioActual == null) {
            return "redirect:/login";
        }

        // Obtener asistencia de hoy
        List<Asistencia> asistenciasHoy = asistenciaService.buscarPorIdUsuario(usuarioActual.getId_usuario());
        Asistencia asistenciaHoy = null;
        
        for (Asistencia a : asistenciasHoy) {
            if (a.getFecha().equals(LocalDate.now())) {
                asistenciaHoy = a;
                break;
            }
        }

        if (asistenciaHoy == null) {
            redirectAttributes.addFlashAttribute("error", "Debes marcar entrada primero");
        } else if (asistenciaHoy.getHoraSalida() != null) {
            redirectAttributes.addFlashAttribute("warning", "Ya marcaste salida hoy");
        } else {
            asistenciaHoy.setHoraSalida(LocalTime.now());
            asistenciaService.actualizar(asistenciaHoy);
            redirectAttributes.addFlashAttribute("success", "¡Salida marcada correctamente!");
        }

        return "redirect:/vendedor/index";
    }

    @GetMapping("/asistencia")
    public String asistencia(HttpSession session, Model model) {
        Usuario usuarioActual = (Usuario) session.getAttribute("usuarioActual");
        
        if (usuarioActual != null) {
            List<Asistencia> miAsistencia = asistenciaService.buscarPorIdUsuario(usuarioActual.getId_usuario());
            model.addAttribute("asistencias", miAsistencia);
        }
        
        return "vendedor/asistencia";
    }
}
