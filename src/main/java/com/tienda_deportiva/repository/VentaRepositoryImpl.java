package com.tienda_deportiva.repository;

import com.tienda_deportiva.model.Venta;
import com.tienda_deportiva.model.DetalleVenta;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Repository
public class VentaRepositoryImpl implements VentaRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private Venta mapRowVenta(ResultSet rs, int rowNum) throws SQLException {
        Venta v = new Venta();
        v.setIdVenta(rs.getLong("id_venta"));
        v.setFecha(rs.getDate("fecha").toLocalDate());
        v.setTotal(rs.getDouble("total"));
        v.setEstado(rs.getString("estado"));
        v.setIdUsuario(rs.getLong("id_usuario"));
        v.setIdCliente(rs.getLong("id_cliente"));

        try {
            v.setNombreEmpleado(rs.getString("nombre_empleado"));
        } catch (SQLException e) {
            v.setNombreEmpleado(null);
        }
        try {
            v.setNombreCliente(rs.getString("nombre_cliente"));
        } catch (SQLException e) {
            v.setNombreCliente(null);
        }
        try {
            v.setDniCliente(rs.getString("dni_cliente"));
        } catch (SQLException e) {
            v.setDniCliente(null);
        }

        return v;
    }

    private DetalleVenta mapRowDetalle(ResultSet rs, int rowNum) throws SQLException {
        DetalleVenta d = new DetalleVenta();
        d.setIdDetalle(rs.getLong("id_detalle"));
        d.setIdVenta(rs.getLong("id_venta"));
        d.setIdProducto(rs.getLong("id_producto"));
        d.setCantidad(rs.getInt("cantidad"));
        d.setPrecioUnitario(rs.getDouble("precio_unitario"));
        d.setSubtotal(rs.getDouble("subtotal"));

        try {
            d.setNombreProducto(rs.getString("nombre_producto"));
        } catch (SQLException e) {
            d.setNombreProducto(null);
        }

        return d;
    }

    @Override
    public List<Venta> listarTodas() {
        String sql = "SELECT v.*, " +
                "u.nombre_completo AS nombre_empleado, " +
                "c.nombre AS nombre_cliente, " +
                "c.dni AS dni_cliente " +
                "FROM venta v " +
                "LEFT JOIN usuario u ON v.id_usuario = u.id_usuario " +
                "LEFT JOIN cliente c ON v.id_cliente = c.id_cliente " +
                "ORDER BY v.fecha DESC, v.id_venta DESC";
        return jdbcTemplate.query(sql, this::mapRowVenta);
    }

    @Override
    public List<Venta> listarPorUsuario(Long idUsuario) {
        String sql = "SELECT v.*, " +
                "u.nombre_completo AS nombre_empleado, " +
                "c.nombre AS nombre_cliente, " +
                "c.dni AS dni_cliente " +
                "FROM venta v " +
                "LEFT JOIN usuario u ON v.id_usuario = u.id_usuario " +
                "LEFT JOIN cliente c ON v.id_cliente = c.id_cliente " +
                "WHERE v.id_usuario = ? " +
                "ORDER BY v.fecha DESC, v.id_venta DESC";
        return jdbcTemplate.query(sql, this::mapRowVenta, idUsuario);
    }

    @Override
    public Venta buscarPorId(Long id) {
        String sql = "SELECT v.*, " +
                "u.nombre_completo AS nombre_empleado, " +
                "c.nombre AS nombre_cliente, " +
                "c.dni AS dni_cliente " +
                "FROM venta v " +
                "LEFT JOIN usuario u ON v.id_usuario = u.id_usuario " +
                "LEFT JOIN cliente c ON v.id_cliente = c.id_cliente " +
                "WHERE v.id_venta = ?";
        return jdbcTemplate.query(sql, rs -> rs.next() ? mapRowVenta(rs, 1) : null, id);
    }

    @Override
    public List<DetalleVenta> buscarDetallesPorVenta(Long idVenta) {
        String sql = "SELECT d.*, p.nombre AS nombre_producto " +
                "FROM detalle_venta d " +
                "LEFT JOIN producto p ON d.id_producto = p.id_producto " +
                "WHERE d.id_venta = ?";
        return jdbcTemplate.query(sql, this::mapRowDetalle, idVenta);
    }

    @Override
    public Long guardar(Venta venta) {
        String sql = "INSERT INTO venta (fecha, total, estado, id_usuario, id_cliente) " +
                "VALUES (?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql,
                venta.getFecha(),
                venta.getTotal(),
                venta.getEstado(),
                venta.getIdUsuario(),
                venta.getIdCliente());

        String sqlId = "SELECT MAX(id_venta) FROM venta";
        return jdbcTemplate.queryForObject(sqlId, Long.class);
    }

    @Override
    public Long guardarCliente(String nombre, String dni) {

        String sqlBuscar = "SELECT id_cliente FROM cliente WHERE dni = ?";
        try {
            return jdbcTemplate.queryForObject(sqlBuscar, Long.class, dni);
        } catch (Exception e) {

            String sql = "INSERT INTO cliente (nombre, dni) VALUES (?, ?)";
            jdbcTemplate.update(sql, nombre, dni);

            String sqlId = "SELECT MAX(id_cliente) FROM cliente";
            return jdbcTemplate.queryForObject(sqlId, Long.class);
        }
    }

    @Override
    public void guardarDetalle(DetalleVenta detalle) {
        String sql = "INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario, subtotal) " +
                "VALUES (?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql,
                detalle.getIdVenta(),
                detalle.getIdProducto(),
                detalle.getCantidad(),
                detalle.getPrecioUnitario(),
                detalle.getSubtotal());
    }

    @Override
    public Map<String, Object> obtenerMetricasGenerales() {
        String sql = "SELECT " +
                "COUNT(*) as total_ventas, " +
                "COALESCE(SUM(total), 0) as ingresos_totales, " +
                "(SELECT COUNT(*) FROM producto WHERE estado = TRUE) as productos_activos, " +
                "(SELECT COUNT(*) FROM usuario WHERE cargo = 'Vendedor' AND estado = TRUE) as empleados_activos " +
                "FROM venta";

        return jdbcTemplate.queryForMap(sql);
    }

    @Override
    public List<Map<String, Object>> obtenerVentasMensuales() {
        String sql = "SELECT " +
                "MONTH(fecha) as mes, " +
                "YEAR(fecha) as anio, " +
                "COALESCE(SUM(total), 0) as total_mes, " +
                "COUNT(*) as cant_ventas_mes " +
                "FROM venta " +
                "WHERE YEAR(fecha) = YEAR(CURRENT_DATE) " +
                "GROUP BY MONTH(fecha), YEAR(fecha) " +
                "ORDER BY mes";

        return jdbcTemplate.queryForList(sql);
    }

    @Override
    public List<Map<String, Object>> obtenerVentasDiarias() {
        String sql = "SELECT " +
                "CAST(fecha AS DATE) as fecha_venta, " +
                "COALESCE(SUM(total), 0) as total_dia, " +
                "COUNT(*) as cantidad_ventas " +
                "FROM venta " +
                "WHERE fecha >= DATEADD('DAY', -14, CURRENT_DATE) " +
                "GROUP BY CAST(fecha AS DATE) " +
                "ORDER BY fecha_venta";

        return jdbcTemplate.queryForList(sql);
    }

    @Override
    public List<Map<String, Object>> obtenerAsistenciaMensual() {
        String sql = "SELECT " +
                "MONTH(a.fecha) as mes, " +
                "YEAR(a.fecha) as anio, " +
                "COUNT(DISTINCT a.id_usuario) as empleados_asistieron, " +
                "COUNT(*) as total_registros, " +
                "COUNT(CASE WHEN a.hora_ingreso > u.hora_entrada THEN 1 END) as llegadas_tarde, " +
                "(SELECT COUNT(*) FROM usuario WHERE cargo = 'Vendedor' AND estado = TRUE) as total_empleados " +
                "FROM asistencia a " +
                "INNER JOIN usuario u ON a.id_usuario = u.id_usuario " +
                "WHERE YEAR(a.fecha) = YEAR(CURRENT_DATE) " +
                "AND u.cargo = 'Vendedor' AND u.estado = TRUE " +
                "GROUP BY MONTH(a.fecha), YEAR(a.fecha) " +
                "ORDER BY mes";

        return jdbcTemplate.queryForList(sql);
    }

    @Override
    public List<Map<String, Object>> obtenerVentasDiarias30Dias() {
        // Métrica 1: Ventas Diarias (Últimos 30 días)
        // Obtiene el total de ventas y cantidad de transacciones por día
        String sql = "SELECT " +
                "CAST(v.fecha AS DATE) as fecha_venta, " +
                "COALESCE(SUM(v.total), 0) as total_dia, " +
                "COUNT(*) as cantidad_ventas, " +
                "COUNT(DISTINCT v.id_usuario) as empleados_activos " +
                "FROM venta v " +
                "WHERE v.fecha >= DATEADD('DAY', -30, CURRENT_DATE) " +
                "GROUP BY CAST(v.fecha AS DATE) " +
                "ORDER BY fecha_venta DESC";

        return jdbcTemplate.queryForList(sql);
    }

    @Override
    public List<Map<String, Object>> obtenerAsistenciaSemanal() {
        // Métrica 2: Asistencia Acumulada Semanal (compatibilidad H2)
        // Agrupa por número de semana y año, además por empleado
        String sql = "SELECT " +
                "EXTRACT(WEEK FROM a.fecha) as num_semana, " +
                "EXTRACT(YEAR FROM a.fecha) as anio, " +
                "a.id_usuario, " +
                "u.nombre_completo as nombre_empleado, " +
                "COUNT(a.id_asistencia) as total_asistencias, " +
                "SUM(CASE WHEN a.hora_ingreso > u.hora_entrada THEN 1 ELSE 0 END) as llegadas_tarde, " +
                "MIN(a.fecha) as inicio_semana, " +
                "MAX(a.fecha) as fin_semana " +
                "FROM asistencia a " +
                "INNER JOIN usuario u ON a.id_usuario = u.id_usuario " +
                "WHERE u.cargo = 'Vendedor' AND u.estado = TRUE " +
                "AND a.fecha >= DATEADD('WEEK', -12, CURRENT_DATE) " +
                "GROUP BY EXTRACT(WEEK FROM a.fecha), EXTRACT(YEAR FROM a.fecha), a.id_usuario, u.nombre_completo, u.hora_entrada " +
                "ORDER BY anio DESC, num_semana DESC";

        return jdbcTemplate.queryForList(sql);
    }

    @Override
    public List<Map<String, Object>> obtenerVentasPorCategoria6Meses() {
        // Métrica 3: Ventas por Categoría (Últimos 6 meses)
        // Obtiene la evolución mensual de ventas por cada categoría
        String sql = "SELECT " +
                "MONTH(v.fecha) as mes, " +
                "YEAR(v.fecha) as anio, " +
                "c.id_categoria, " +
                "c.nombre as nombre_categoria, " +
                "COALESCE(SUM(dv.subtotal), 0) as total_ventas, " +
                "COUNT(DISTINCT dv.id_producto) as cantidad_productos, " +
                "COUNT(DISTINCT v.id_venta) as numero_transacciones " +
                "FROM venta v " +
                "INNER JOIN detalle_venta dv ON v.id_venta = dv.id_venta " +
                "INNER JOIN producto p ON dv.id_producto = p.id_producto " +
                "INNER JOIN categoria c ON p.id_categoria = c.id_categoria " +
                "WHERE v.fecha >= DATEADD('MONTH', -6, CURRENT_DATE) " +
                "AND c.estado = TRUE " +
                "GROUP BY MONTH(v.fecha), YEAR(v.fecha), c.id_categoria, c.nombre " +
                "ORDER BY anio DESC, mes DESC, total_ventas DESC";

        return jdbcTemplate.queryForList(sql);
    }
}