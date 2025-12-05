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

    Map<String, Object> obtenerMetricasGenerales();

    List<Map<String, Object>> obtenerVentasMensuales();

    List<Map<String, Object>> obtenerVentasDiarias();

    List<Map<String, Object>> obtenerAsistenciaMensual();

    /**
     * Obtiene ventas diarias de los últimos 30 días.
     */
    List<Map<String, Object>> obtenerVentasDiarias30Dias();

    /**
     * Obtiene asistencia acumulada semanal por empleado.
     */
    List<Map<String, Object>> obtenerAsistenciaSemanal();

    /**
     * Obtiene evolución de ventas por categoría (últimos 6 meses).
     */
    List<Map<String, Object>> obtenerVentasPorCategoria6Meses();
}
