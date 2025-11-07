package com.tienda_deportiva.controller;

import com.tienda_deportiva.service.ProductoService;
import com.tienda_deportiva.service.CategoriaService;
import com.tienda_deportiva.service.VentaService;
import com.tienda_deportiva.model.Venta;
import com.tienda_deportiva.model.DetalleVenta;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

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
    
    @GetMapping("/index")
    public String index() {
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

    // Endpoint temporal para venta-detalle sin ID (usa sessionStorage)
    @GetMapping("/venta-detalle")
    public String ventaDetalleTemp() {
        return "vendedor/venta-detalle";
    }

    // Endpoint para venta-detalle con ID (usa base de datos)
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
        // Por ahora, usamos id_usuario = 2 (Alonso García) como ejemplo
        Long idUsuarioLogueado = 2L;
        
        // Obtener solo las ventas de este empleado usando DAO
        List<Venta> ventasEmpleado = ventaService.listarPorUsuario(idUsuarioLogueado);
        
        model.addAttribute("ventas", ventasEmpleado);
        return "vendedor/ventas-empleado";
    }

    @GetMapping("/asistencia")
    public String asistencia() {
        return "vendedor/asistencia";
    }

}
