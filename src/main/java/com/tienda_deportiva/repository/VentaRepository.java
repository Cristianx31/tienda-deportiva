package com.tienda_deportiva.repository;

import com.tienda_deportiva.model.Venta;
import com.tienda_deportiva.model.DetalleVenta;
import java.util.List;
import java.util.Map;

public interface VentaRepository {
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
     * Query SQL retorna: fecha_venta, total_dia, cantidad_ventas
     */
    List<Map<String, Object>> obtenerVentasDiarias30Dias();

    /**
     * Obtiene asistencia acumulada semanal por empleado.
     * Query SQL retorna: num_semana, anio, id_usuario, nombre_empleado, total_asistencias
     */
    List<Map<String, Object>> obtenerAsistenciaSemanal();

    /**
     * Obtiene evolución de ventas por categoría (últimos 6 meses).
     * Query SQL retorna: mes, anio, id_categoria, nombre_categoria, total_ventas, cantidad_productos
     */
    List<Map<String, Object>> obtenerVentasPorCategoria6Meses();
}
