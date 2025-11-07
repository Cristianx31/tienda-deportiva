package com.tienda_deportiva.controller;

import com.tienda_deportiva.service.EmpleadoService;
import com.tienda_deportiva.service.CategoriaService;
import com.tienda_deportiva.service.ProductoService;
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
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private EmpleadoService empleadoService;

    @Autowired
    private CategoriaService categoriaService;

    @Autowired
    private ProductoService productoService;

    @Autowired
    private VentaService ventaService;

    @GetMapping("/gestion")
    public String gestion(Model model) {
        model.addAttribute("empleados", empleadoService.listarTodos());
        model.addAttribute("categorias", categoriaService.listarTodas());
        model.addAttribute("productos", productoService.listarTodos());
        model.addAttribute("ventas", ventaService.listarTodas());
        return "admin/gestion";
    }

    @GetMapping("/perfil-admin")
    public String perfilAdmin() {
        return "admin/perfil-admin";
    }

    @GetMapping("/venta-detalle/{id}")
    public String ventaDetalle(@PathVariable Long id, Model model) {
        Venta venta = ventaService.buscarPorId(id);
        List<DetalleVenta> detalles = ventaService.buscarDetallesPorVenta(id);
        
        model.addAttribute("venta", venta);
        model.addAttribute("detalles", detalles);
        
        return "admin/venta-detalle";
    }

    @GetMapping("/venta-anular/{id}")
    public String anularVenta(@PathVariable Long id) {
        ventaService.anularVenta(id);
        return "redirect:/admin/gestion";
    }

    @GetMapping("/metricas")
    public String metricas(Model model) {
        // Métricas generales
        Map<String, Object> metricas = ventaService.obtenerMetricasGenerales();
        model.addAttribute("totalVentas", metricas.get("total_ventas"));
        model.addAttribute("ingresosTotales", metricas.get("ingresos_totales"));
        model.addAttribute("productosActivos", metricas.get("productos_activos"));
        model.addAttribute("empleadosActivos", metricas.get("empleados_activos"));
        
        // Ventas mensuales
        List<Map<String, Object>> ventasMensuales = ventaService.obtenerVentasMensuales();
        model.addAttribute("ventasMensuales", ventasMensuales);
        
        // Categoría más vendida del mes
        List<Map<String, Object>> categorias = ventaService.obtenerCategoriaMasVendidaMes();
        model.addAttribute("categoriasMes", categorias);
        
        // Inventario crítico
        List<Map<String, Object>> inventarioCritico = ventaService.obtenerInventarioCritico();
        model.addAttribute("inventarioCritico", inventarioCritico);
        
        // Asistencia de empleados
        Map<String, Object> asistencia = ventaService.obtenerAsistenciaEmpleados();
        model.addAttribute("asistencia", asistencia);
        
        return "admin/metricas";
    }
}
