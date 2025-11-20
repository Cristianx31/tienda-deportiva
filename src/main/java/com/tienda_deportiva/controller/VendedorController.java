package com.tienda_deportiva.controller;

import com.tienda_deportiva.service.ProductoService;
import com.tienda_deportiva.service.CategoriaService;
import com.tienda_deportiva.service.VentaService;
import com.tienda_deportiva.service.AsistenciaService;
import com.tienda_deportiva.service.SecurityService;
import com.tienda_deportiva.model.Venta;
import com.tienda_deportiva.model.DetalleVenta;
import com.tienda_deportiva.model.Asistencia;
import com.tienda_deportiva.model.Usuario;
import com.tienda_deportiva.model.CarritoItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpSession;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.ArrayList;

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

    @Autowired
    private SecurityService securityService;
    
    @GetMapping("/index")
    public String index(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarVendedor(session, redirectAttributes);
        if (validacion != null) return validacion;
        
        Usuario usuarioActual = (Usuario) session.getAttribute("usuarioActual");
        if (usuarioActual != null) {
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
    public String perfilVendedor(HttpSession session, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarVendedor(session, redirectAttributes);
        if (validacion != null) return validacion;
        
        return "vendedor/perfil-vendedor";
    }
    
    @GetMapping("/catalogo")
    public String catalogo(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarVendedor(session, redirectAttributes);
        if (validacion != null) return validacion;
        
        model.addAttribute("productos", productoService.listarTodos());
        model.addAttribute("categorias", categoriaService.listarTodas());
        return "vendedor/catalogo";
    }
    
    @GetMapping("/publicidad")
    public String publicidad(HttpSession session, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarVendedor(session, redirectAttributes);
        if (validacion != null) return validacion;
        
        return "vendedor/publicidad";
    }
    
    @GetMapping("/contacto")
    public String contacto(HttpSession session, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarVendedor(session, redirectAttributes);
        if (validacion != null) return validacion;
        
        return "vendedor/contacto";
    }
    
    @GetMapping("/producto-detalle/{id}")
    public String productoDetalle(@PathVariable Long id, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarVendedor(session, redirectAttributes);
        if (validacion != null) return validacion;
        
        model.addAttribute("producto", productoService.buscarPorId(id));
        return "vendedor/producto-detalle";
    }

    @GetMapping("/venta")
    public String venta(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarVendedor(session, redirectAttributes);
        if (validacion != null) return validacion;
        
        List<CarritoItem> carrito = obtenerCarrito(session);
        double total = carrito.stream()
                .mapToDouble(i -> i.getPrecio() * i.getCantidad())
                .sum();
        
        model.addAttribute("carrito", carrito);
        model.addAttribute("total", total);
        return "vendedor/venta";
    }

    @GetMapping("/venta-detalle")
    public String ventaDetalleTemp(HttpSession session, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarVendedor(session, redirectAttributes);
        if (validacion != null) return validacion;
        
        return "vendedor/venta-detalle";
    }

    @GetMapping("/venta-detalle/{id}")
    public String ventaDetalle(@PathVariable Long id, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarVendedor(session, redirectAttributes);
        if (validacion != null) return validacion;
        
        Venta venta = ventaService.buscarPorId(id);
        List<DetalleVenta> detalles = ventaService.buscarDetallesPorVenta(id);
        
        model.addAttribute("venta", venta);
        model.addAttribute("detalles", detalles);
        
        return "vendedor/venta-detalle";
    }

    @GetMapping("/ventas-empleado")
    public String ventasEmpleado(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarVendedor(session, redirectAttributes);
        if (validacion != null) return validacion;
        
        Usuario usuarioActual = (Usuario) session.getAttribute("usuarioActual");
        List<Venta> ventasEmpleado = ventaService.listarPorUsuario(usuarioActual.getId_usuario().longValue());
        model.addAttribute("ventas", ventasEmpleado);
        return "vendedor/ventas-empleado";
    }

    @GetMapping("/ventas")
    public String ventas(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarVendedor(session, redirectAttributes);
        if (validacion != null) return validacion;
        
        model.addAttribute("ventas", ventaService.listarTodas());
        return "vendedor/ventas";
    }

    @PostMapping("/marcar-entrada")
    public String marcarEntrada(HttpSession session, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarVendedor(session, redirectAttributes);
        if (validacion != null) return validacion;
        
        Usuario usuarioActual = (Usuario) session.getAttribute("usuarioActual");

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

        return "redirect:/vendedor/asistencia";
    }

    @PostMapping("/marcar-salida")
    public String marcarSalida(HttpSession session, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarVendedor(session, redirectAttributes);
        if (validacion != null) return validacion;
        
        Usuario usuarioActual = (Usuario) session.getAttribute("usuarioActual");

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

        return "redirect:/vendedor/asistencia";
    }

    @GetMapping("/asistencia")
    public String asistencia(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarVendedor(session, redirectAttributes);
        if (validacion != null) return validacion;
        
        Usuario usuarioActual = (Usuario) session.getAttribute("usuarioActual");
        
        if (usuarioActual != null) {
            // Obtener asistencia del día actual
            Asistencia asistenciaHoy = asistenciaService.buscarPorUsuarioYFecha(
                usuarioActual.getId_usuario(), 
                LocalDate.now()
            );
            
            // Obtener todas las asistencias del usuario (últimos 30 días)
            List<Asistencia> misAsistencias = asistenciaService.buscarPorIdUsuario(usuarioActual.getId_usuario());
            
            model.addAttribute("asistenciaHoy", asistenciaHoy);
            model.addAttribute("asistencias", misAsistencias);
        }
        
        return "vendedor/asistencia";
    }

    @GetMapping("/historial-asistencia")
    public String historialAsistencia(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarVendedor(session, redirectAttributes);
        if (validacion != null) return validacion;
        
        Usuario usuarioActual = (Usuario) session.getAttribute("usuarioActual");
        
        if (usuarioActual != null) {
            // Obtener TODAS las asistencias del usuario
            List<Asistencia> todasAsistencias = asistenciaService.buscarPorIdUsuario(usuarioActual.getId_usuario());
            model.addAttribute("asistencias", todasAsistencias);
            model.addAttribute("usuario", usuarioActual);
        }
        
        return "vendedor/historial-asistencia";
    }

    @SuppressWarnings("unchecked")
    private List<CarritoItem> obtenerCarrito(HttpSession session) {
        List<CarritoItem> carrito = (List<CarritoItem>) session.getAttribute("carrito");
        if (carrito == null) {
            carrito = new ArrayList<>();
            session.setAttribute("carrito", carrito);
        }
        return carrito;
    }

    @PostMapping("/carrito/agregar")
    public String agregarAlCarrito(
            HttpSession session,
            @RequestParam Long idProducto,
            @RequestParam String nombre,
            @RequestParam Double precio,
            @RequestParam String imagen,
            @RequestParam(defaultValue = "1") Integer cantidad) {
        
        List<CarritoItem> carrito = obtenerCarrito(session);
        
        CarritoItem existente = carrito.stream()
                .filter(i -> i.getIdProducto().equals(idProducto))
                .findFirst()
                .orElse(null);
        
        if (existente != null) {
            existente.setCantidad(existente.getCantidad() + cantidad);
        } else {
            carrito.add(new CarritoItem(idProducto, nombre, precio, imagen, cantidad));
        }
        
        return "redirect:/vendedor/venta";
    }

    @PostMapping("/carrito/actualizar")
    public String actualizarCantidad(
            HttpSession session,
            @RequestParam Long idProducto,
            @RequestParam Integer cantidad) {
        
        List<CarritoItem> carrito = obtenerCarrito(session);
        
        CarritoItem item = carrito.stream()
                .filter(i -> i.getIdProducto().equals(idProducto))
                .findFirst()
                .orElse(null);
        
        if (item != null && cantidad > 0) {
            item.setCantidad(cantidad);
        }
        
        return "redirect:/vendedor/venta";
    }

    @GetMapping("/carrito/eliminar/{id}")
    public String eliminarDelCarrito(
            HttpSession session,
            @PathVariable Long id) {
        
        List<CarritoItem> carrito = obtenerCarrito(session);
        carrito.removeIf(i -> i.getIdProducto().equals(id));
        
        return "redirect:/vendedor/venta";
    }

    @GetMapping("/carrito/limpiar")
    public String limpiarCarrito(HttpSession session) {
        session.removeAttribute("carrito");
        return "redirect:/vendedor/venta";
    }

    @PostMapping("/venta/confirmar")
    public String confirmarVenta(
            HttpSession session,
            @RequestParam String nombreCliente,
            @RequestParam String dniCliente,
            RedirectAttributes redirectAttributes) {
        
        String validacion = securityService.validarVendedor(session, redirectAttributes);
        if (validacion != null) return validacion;

        List<CarritoItem> carrito = obtenerCarrito(session);
        
        if (carrito.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "El carrito está vacío");
            return "redirect:/vendedor/venta";
        }
        
        if (nombreCliente == null || nombreCliente.trim().isEmpty() || nombreCliente.length() < 3) {
            redirectAttributes.addFlashAttribute("error", "Nombre de cliente inválido");
            return "redirect:/vendedor/venta";
        }
        
        if (dniCliente == null || !dniCliente.matches("\\d{8}")) {
            redirectAttributes.addFlashAttribute("error", "DNI debe tener 8 dígitos");
            return "redirect:/vendedor/venta";
        }
        
        try {
            // 1. Guardar cliente
            Long idCliente = ventaService.guardarCliente(nombreCliente, dniCliente);
            
            // 2. Crear y guardar venta
            Venta venta = new Venta();
            venta.setFecha(LocalDate.now());
            venta.setTotal(carrito.stream()
                    .mapToDouble(i -> i.getPrecio() * i.getCantidad())
                    .sum());
            venta.setEstado("Completada");
            venta.setIdCliente(idCliente);
            
            Usuario usuarioActual = (Usuario) session.getAttribute("usuarioActual");
            if (usuarioActual != null) {
                venta.setIdUsuario(usuarioActual.getId_usuario().longValue());
            }
            
            Long idVenta = ventaService.guardar(venta);
            
            // 3. Guardar detalles de venta
            for (CarritoItem item : carrito) {
                DetalleVenta detalle = new DetalleVenta();
                detalle.setIdVenta(idVenta);
                detalle.setIdProducto(item.getIdProducto());
                detalle.setCantidad(item.getCantidad());
                detalle.setPrecioUnitario(item.getPrecio());
                detalle.setSubtotal(item.getPrecio() * item.getCantidad());
                ventaService.guardarDetalle(detalle);
            }
            
            // 4. Limpiar carrito
            session.removeAttribute("carrito");
            
            redirectAttributes.addFlashAttribute("success", "¡Venta registrada exitosamente! ID: " + idVenta);
            return "redirect:/vendedor/venta-detalle/" + idVenta;
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error al guardar la venta: " + e.getMessage());
            return "redirect:/vendedor/venta";
        }
    }
}
