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
import com.tienda_deportiva.model.Cliente;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpSession;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.ArrayList;

/**
 * Controlador para la gestión del flujo de ventas de la tienda deportiva.
 *
 * Cambios principales realizados:
 * - Usa @SessionAttributes para mantener un objeto "cliente" (Cliente) y "carrito" (List<CarritoItem>)
 *   en la sesión y se inicializan mediante métodos @ModelAttribute.
 * - Todas las operaciones sobre el carrito usan @ModelAttribute para no perder los datos del cliente
 *   al agregar/ajustar/eliminar productos.
 * - Confirmar venta valida el DNI (8 dígitos) y el nombre antes de persistir; limpia solo el carrito
 *   (no borra automáticamente los datos del cliente de la sesión, según regla de negocio).
 */
@Controller
@RequestMapping("/vendedor")
@SessionAttributes({"cliente", "carrito"})
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

    /**
     * Inicializa el atributo de sesión "cliente" si no existe.
     * Se mantiene en sesión mientras dure el flujo de venta.
     */
    @ModelAttribute("cliente")
    public Cliente inicializarCliente() {
        return new Cliente();
    }

    /**
     * Inicializa el atributo de sesión "carrito" si no existe.
     */
    @ModelAttribute("carrito")
    public List<CarritoItem> inicializarCarrito() {
        return new ArrayList<>();
    }

    @GetMapping("/index")
    public String index(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarVendedor(session, redirectAttributes);
        if (validacion != null)
            return validacion;

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
        if (validacion != null)
            return validacion;

        return "vendedor/perfil-vendedor";
    }

    @GetMapping("/catalogo")
    public String catalogo(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarVendedor(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        model.addAttribute("productos", productoService.listarTodos());
        model.addAttribute("categorias", categoriaService.listarTodas());
        return "vendedor/catalogo";
    }

    @GetMapping("/publicidad")
    public String publicidad(HttpSession session, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarVendedor(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        return "vendedor/publicidad";
    }

    @GetMapping("/contacto")
    public String contacto(HttpSession session, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarVendedor(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        return "vendedor/contacto";
    }

    @GetMapping("/producto-detalle/{id}")
    public String productoDetalle(@PathVariable Long id, HttpSession session, Model model,
            RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarVendedor(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        model.addAttribute("producto", productoService.buscarPorId(id));
        return "vendedor/producto-detalle";
    }

    /**
     * Muestra el formulario de venta con el carrito y datos del cliente.
     *
     * Usa @ModelAttribute para recibir el objeto "cliente" y la lista "carrito" mantenidos en sesión.
     */
    @GetMapping("/venta")
    public String venta(HttpSession session, Model model, RedirectAttributes redirectAttributes,
            @ModelAttribute("cliente") Cliente cliente,
            @ModelAttribute("carrito") List<CarritoItem> carrito) {
        String validacion = securityService.validarVendedor(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        // Orden y cálculo del total
        carrito.sort((a, b) -> a.getIdProducto().compareTo(b.getIdProducto()));

        double total = carrito.stream()
                .mapToDouble(i -> i.getPrecio() * i.getCantidad())
                .sum();

        // Agregar datos a la vista
        model.addAttribute("carrito", carrito);
        model.addAttribute("total", total);
        model.addAttribute("productos", productoService.listarTodos());
        model.addAttribute("categorias", categoriaService.listarTodas());
        model.addAttribute("cliente", cliente);

        // Garantizar persistencia explícita en la sesión (redundancia con @SessionAttributes)
        session.setAttribute("cliente", cliente);
        session.setAttribute("carrito", carrito);

        return "vendedor/venta";
    }

    @GetMapping("/venta-detalle/{id}")
    public String ventaDetalle(@PathVariable Long id, HttpSession session, Model model,
            RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarVendedor(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        Venta venta = ventaService.buscarPorId(id);
        List<DetalleVenta> detalles = ventaService.buscarDetallesPorVenta(id);

        model.addAttribute("venta", venta);
        model.addAttribute("detalles", detalles);

        return "vendedor/venta-detalle";
    }

    @GetMapping("/ventas-empleado")
    public String ventasEmpleado(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarVendedor(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        Usuario usuarioActual = (Usuario) session.getAttribute("usuarioActual");
        List<Venta> ventasEmpleado = ventaService.listarPorUsuario(usuarioActual.getId_usuario().longValue());
        model.addAttribute("ventas", ventasEmpleado);
        return "vendedor/ventas-empleado";
    }

    @GetMapping("/ventas")
    public String ventas(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarVendedor(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        model.addAttribute("ventas", ventaService.listarTodas());
        return "vendedor/ventas";
    }

    @PostMapping("/marcar-entrada")
    public String marcarEntrada(HttpSession session, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarVendedor(session, redirectAttributes);
        if (validacion != null)
            return validacion;

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
        if (validacion != null)
            return validacion;

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
        if (validacion != null)
            return validacion;

        Usuario usuarioActual = (Usuario) session.getAttribute("usuarioActual");

        if (usuarioActual != null) {

            Asistencia asistenciaHoy = asistenciaService.buscarPorUsuarioYFecha(
                    usuarioActual.getId_usuario(),
                    LocalDate.now());

            List<Asistencia> misAsistencias = asistenciaService.buscarPorIdUsuario(usuarioActual.getId_usuario());

            model.addAttribute("asistenciaHoy", asistenciaHoy);
            model.addAttribute("asistencias", misAsistencias);
        }

        return "vendedor/asistencia";
    }

    @GetMapping("/historial-asistencia")
    public String historialAsistencia(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarVendedor(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        Usuario usuarioActual = (Usuario) session.getAttribute("usuarioActual");

        if (usuarioActual != null) {

            List<Asistencia> todasAsistencias = asistenciaService.buscarPorIdUsuario(usuarioActual.getId_usuario());
            model.addAttribute("asistencias", todasAsistencias);
            model.addAttribute("usuario", usuarioActual);
        }

        return "vendedor/historial-asistencia";
    }

    /**
     * Guarda/actualiza los datos del cliente en sesión (endpoint dedicado).
     */
    @PostMapping("/cliente/guardar")
    public String guardarCliente(
            @RequestParam String clienteNombre,
            @RequestParam String clienteDni,
            @ModelAttribute("cliente") Cliente cliente,
            Model model,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        if (clienteNombre != null) cliente.setNombre(clienteNombre.trim());
        if (clienteDni != null) cliente.setDni(clienteDni.trim());

        // Actualizar el atributo en el modelo y en la sesión (más seguro)
        model.addAttribute("cliente", cliente);
        session.setAttribute("cliente", cliente);

        redirectAttributes.addFlashAttribute("success", "Datos del cliente actualizados");
        return "redirect:/vendedor/venta";
    }

    /**
     * Agrega un producto al carrito sin tocar los datos del cliente en sesión.
     */
    @PostMapping("/carrito/agregar")
    public String agregarAlCarrito(
            @RequestParam Long idProducto,
            @RequestParam(defaultValue = "1") Integer cantidad,
            @RequestParam(required = false) String clienteNombre,
            @RequestParam(required = false) String clienteDni,
            @ModelAttribute("carrito") List<CarritoItem> carrito,
            @ModelAttribute("cliente") Cliente cliente,
            Model model,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        // Si el formulario envía datos de cliente, actualizarlos en sesión (vía modelo y session)
        if (clienteNombre != null && !clienteNombre.trim().isEmpty()) {
            cliente.setNombre(clienteNombre.trim());
            model.addAttribute("cliente", cliente);
            session.setAttribute("cliente", cliente);
        }
        if (clienteDni != null && !clienteDni.trim().isEmpty()) {
            cliente.setDni(clienteDni.trim());
            model.addAttribute("cliente", cliente);
            session.setAttribute("cliente", cliente);
        }

        var producto = productoService.buscarPorId(idProducto);
        if (producto == null) {
            redirectAttributes.addFlashAttribute("error", "Producto no encontrado");
            return "redirect:/vendedor/venta";
        }

        CarritoItem existente = carrito.stream()
                .filter(i -> i.getIdProducto().equals(idProducto))
                .findFirst()
                .orElse(null);

        if (existente != null) {
            existente.setCantidad(existente.getCantidad() + cantidad);
        } else {
            carrito.add(new CarritoItem(producto.getIdProducto(), producto.getNombre(), producto.getPrecio(), producto.getImagen(), cantidad));
        }

        // Actualizar carrito en modelo y sesión
        model.addAttribute("carrito", carrito);
        session.setAttribute("carrito", carrito);

        redirectAttributes.addFlashAttribute("success", "Producto agregado");
        return "redirect:/vendedor/venta";
    }

    /**
     * Ajusta la cantidad de un producto en el carrito. No modifica el objeto Cliente.
     */
    @PostMapping("/carrito/ajustar")
    public String ajustarCantidad(
            @RequestParam Long idProducto,
            @RequestParam String accion,
            @RequestParam(required = false) String clienteNombre,
            @RequestParam(required = false) String clienteDni,
            @ModelAttribute("carrito") List<CarritoItem> carrito,
            @ModelAttribute("cliente") Cliente cliente,
            Model model,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        // Si el formulario envía datos de cliente, actualizarlos en sesión
        if (clienteNombre != null && !clienteNombre.trim().isEmpty()) {
            cliente.setNombre(clienteNombre.trim());
            model.addAttribute("cliente", cliente);
            session.setAttribute("cliente", cliente);
        }
        if (clienteDni != null && !clienteDni.trim().isEmpty()) {
            cliente.setDni(clienteDni.trim());
            model.addAttribute("cliente", cliente);
            session.setAttribute("cliente", cliente);
        }

        for (CarritoItem i : carrito) {
            if (i.getIdProducto().equals(idProducto)) {
                if ("inc".equals(accion)) {
                    i.setCantidad(i.getCantidad() + 1);
                } else if ("dec".equals(accion)) {
                    i.setCantidad(Math.max(1, i.getCantidad() - 1));
                }
                break;
            }
        }

        // Actualizar carrito en modelo y sesión (no tocar cliente).
        model.addAttribute("carrito", carrito);
        session.setAttribute("carrito", carrito);

        return "redirect:/vendedor/venta#item-" + idProducto;
    }

    /**
     * Confirma y registra la venta en la base de datos. Mantiene cliente en sesión y limpia solo el carrito.
     */
    @PostMapping("/venta/confirmar")
    public String confirmarVenta(
            @ModelAttribute("cliente") Cliente cliente,
            @ModelAttribute("carrito") List<CarritoItem> carrito,
            @RequestParam(required = false) String clienteNombre,
            @RequestParam(required = false) String clienteDni,
            Model model,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        // Si el formulario incluyó datos de cliente directamente, aplicarlos
        if (clienteNombre != null && !clienteNombre.trim().isEmpty()) {
            cliente.setNombre(clienteNombre.trim());
            model.addAttribute("cliente", cliente);
            session.setAttribute("cliente", cliente);
        }
        if (clienteDni != null && !clienteDni.trim().isEmpty()) {
            cliente.setDni(clienteDni.trim());
            model.addAttribute("cliente", cliente);
            session.setAttribute("cliente", cliente);
        }

        if (carrito == null || carrito.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "El carrito está vacío");
            return "redirect:/vendedor/venta";
        }

        if (cliente.getNombre() == null || cliente.getNombre().trim().length() < 3) {
            redirectAttributes.addFlashAttribute("error",
                    "El nombre del cliente es obligatorio y debe tener mínimo 3 caracteres");
            return "redirect:/vendedor/venta";
        }
        if (cliente.getDni() == null || !cliente.getDni().matches("\\d{8}")) {
            redirectAttributes.addFlashAttribute("error",
                    "El DNI debe contener exactamente 8 dígitos numéricos");
            return "redirect:/vendedor/venta";
        }

        try {
            Long idCliente = ventaService.guardarCliente(cliente.getNombre().trim(), cliente.getDni().trim());

            Venta venta = new Venta();
            venta.setFecha(LocalDate.now());
            venta.setTotal(carrito.stream().mapToDouble(i -> i.getPrecio() * i.getCantidad()).sum());
            venta.setEstado("Pagado");
            venta.setIdCliente(idCliente);

            Usuario usuarioActual = (Usuario) session.getAttribute("usuarioActual");
            if (usuarioActual != null) venta.setIdUsuario(usuarioActual.getId_usuario().longValue());

            Long idVenta = ventaService.guardar(venta);

            for (CarritoItem item : new ArrayList<>(carrito)) {
                DetalleVenta detalle = new DetalleVenta();
                detalle.setIdVenta(idVenta);
                detalle.setIdProducto(item.getIdProducto());
                detalle.setCantidad(item.getCantidad());
                detalle.setPrecioUnitario(item.getPrecio());
                detalle.setSubtotal(item.getPrecio() * item.getCantidad());
                ventaService.guardarDetalle(detalle);
            }

            // limpiar solo el carrito: reemplazar en el modelo y en sesión por lista vacía
            List<CarritoItem> carritoVacio = new ArrayList<>();
            model.addAttribute("carrito", carritoVacio);
            session.setAttribute("carrito", carritoVacio);

            redirectAttributes.addFlashAttribute("success",
                    "¡Venta registrada exitosamente! ID de venta: " + idVenta);
            return "redirect:/vendedor/venta-detalle/" + idVenta;

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error",
                    "Error al guardar la venta: " + e.getMessage());
            return "redirect:/vendedor/venta";
        }
    }

    @GetMapping("/carrito/eliminar/{id}")
    public String eliminarDelCarrito(
            HttpSession session,
            @PathVariable Long id,
            @ModelAttribute("carrito") List<CarritoItem> carrito) {

        carrito.removeIf(i -> i.getIdProducto().equals(id));
        // actualizar sesión
        session.setAttribute("carrito", carrito);

        return "redirect:/vendedor/venta";
    }

    /**
     * Limpia completamente el carrito pero mantiene los datos del cliente.
     */
    @GetMapping("/carrito/limpiar")
    public String limpiarCarrito(HttpSession session, @ModelAttribute("carrito") List<CarritoItem> carrito) {
        carrito.clear();
        // mantener coherencia en sesión
        session.setAttribute("carrito", carrito);
        return "redirect:/vendedor/venta";
    }
}
