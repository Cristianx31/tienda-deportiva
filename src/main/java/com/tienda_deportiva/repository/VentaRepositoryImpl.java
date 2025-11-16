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
        
        // Información adicional si existe en el JOIN
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
        
        // Información adicional del producto si existe
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
                     "ORDER BY v.fecha DESC";
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
                     "ORDER BY v.fecha DESC";
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
    public void guardar(Venta venta) {
        String sql = "INSERT INTO venta (fecha, total, estado, id_usuario, id_cliente) " +
                     "VALUES (?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, 
            venta.getFecha(), 
            venta.getTotal(), 
            venta.getEstado(), 
            venta.getIdUsuario(), 
            venta.getIdCliente());
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
    public void anularVenta(Long idVenta) {
        // 1. Cambiar estado de la venta a "Anulado"
        String sqlVenta = "UPDATE venta SET estado = 'Anulado' WHERE id_venta = ?";
        jdbcTemplate.update(sqlVenta, idVenta);
        
        // 2. Devolver el stock de los productos
        String sqlDetalles = "SELECT id_producto, cantidad FROM detalle_venta WHERE id_venta = ?";
        jdbcTemplate.query(sqlDetalles, (rs) -> {
            Long idProducto = rs.getLong("id_producto");
            Integer cantidad = rs.getInt("cantidad");
            
            String sqlStock = "UPDATE producto SET stock = stock + ? WHERE id_producto = ?";
            jdbcTemplate.update(sqlStock, cantidad, idProducto);
        }, idVenta);
    }
    
    @Override
    public Map<String, Object> obtenerMetricasGenerales() {
        String sql = "SELECT " +
                     "COUNT(*) as total_ventas, " +
                     "COALESCE(SUM(CASE WHEN estado != 'Anulado' THEN total ELSE 0 END), 0) as ingresos_totales, " +
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
                     "COALESCE(SUM(CASE WHEN estado != 'Anulado' THEN total ELSE 0 END), 0) as total_mes " +
                     "FROM venta " +
                     "WHERE YEAR(fecha) = YEAR(CURRENT_DATE) " +
                     "GROUP BY MONTH(fecha), YEAR(fecha) " +
                     "ORDER BY mes";
        
        return jdbcTemplate.queryForList(sql);
    }
    
    @Override
    public List<Map<String, Object>> obtenerCategoriaMasVendidaMes() {
        String sql = "SELECT c.nombre, " +
                     "COUNT(dv.id_detalle) as cantidad_vendida, " +
                     "COALESCE(SUM(dv.subtotal), 0) as total_vendido " +
                     "FROM categoria c " +
                     "LEFT JOIN producto p ON c.id_categoria = p.id_categoria " +
                     "LEFT JOIN detalle_venta dv ON p.id_producto = dv.id_producto " +
                     "LEFT JOIN venta v ON dv.id_venta = v.id_venta " +
                     "WHERE MONTH(v.fecha) = MONTH(CURRENT_DATE) " +
                     "AND YEAR(v.fecha) = YEAR(CURRENT_DATE) " +
                     "AND v.estado != 'Anulado' " +
                     "GROUP BY c.id_categoria, c.nombre " +
                     "ORDER BY cantidad_vendida DESC";
        
        return jdbcTemplate.queryForList(sql);
    }
    
    @Override
    public List<Map<String, Object>> obtenerInventarioCritico() {
        String sql = "SELECT nombre, stock " +
                     "FROM producto " +
                     "WHERE stock < 5 AND estado = TRUE " +
                     "ORDER BY stock ASC";
        
        return jdbcTemplate.queryForList(sql);
    }
    
    @Override
    public Map<String, Object> obtenerAsistenciaEmpleados() {
        String sql = "SELECT " +
                     "(SELECT COUNT(DISTINCT a.id_usuario) " +
                     " FROM asistencia a " +
                     " INNER JOIN usuario u ON a.id_usuario = u.id_usuario " +
                     " WHERE MONTH(a.fecha) = MONTH(DATEADD('MONTH', -1, CURRENT_DATE)) " +
                     " AND YEAR(a.fecha) = YEAR(DATEADD('MONTH', -1, CURRENT_DATE)) " +
                     " AND u.cargo = 'Vendedor' AND u.estado = TRUE) as empleados_asistieron_mes_anterior, " +
                     "(SELECT COUNT(DISTINCT a.id_usuario) " +
                     " FROM asistencia a " +
                     " INNER JOIN usuario u ON a.id_usuario = u.id_usuario " +
                     " WHERE MONTH(a.fecha) = MONTH(CURRENT_DATE) " +
                     " AND YEAR(a.fecha) = YEAR(CURRENT_DATE) " +
                     " AND u.cargo = 'Vendedor' AND u.estado = TRUE) as empleados_asistieron_mes, " +
                     "(SELECT COUNT(*) FROM usuario WHERE cargo = 'Vendedor' AND estado = TRUE) as total_empleados " +
                     "FROM DUAL";
        
        return jdbcTemplate.queryForMap(sql);
    }
}

