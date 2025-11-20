package com.tienda_deportiva.service;

import com.tienda_deportiva.model.Venta;
import com.tienda_deportiva.model.DetalleVenta;
import java.util.List;
import java.util.Map;

public interface VentaService {
    List<Venta> listarTodas();
    
    List<Venta> listarPorUsuario(Long idUsuario);
    
    Venta buscarPorId(Long id);
    
    List<DetalleVenta> buscarDetallesPorVenta(Long idVenta);
    
    Long guardar(Venta venta);
    
    void guardarDetalle(DetalleVenta detalle);
    
    Long guardarCliente(String nombre, String dni);
    
    void anularVenta(Long idVenta);
    
    // Métricas
    Map<String, Object> obtenerMetricasGenerales();
    List<Map<String, Object>> obtenerVentasMensuales();
    List<Map<String, Object>> obtenerCategoriaMasVendidaMes();
    List<Map<String, Object>> obtenerInventarioCritico();
    Map<String, Object> obtenerAsistenciaEmpleados();
}
