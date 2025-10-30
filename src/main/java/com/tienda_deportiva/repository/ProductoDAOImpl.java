package com.tienda_deportiva.repository;

import com.tienda_deportiva.model.Producto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class ProductoDAOImpl implements ProductoRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private Producto mapRow(ResultSet rs, int rowNum) throws SQLException {
        Producto p = new Producto();
        p.setIdProducto(rs.getLong("id_producto"));
        p.setNombre(rs.getString("nombre"));
        p.setDescripcion(rs.getString("descripcion"));
        p.setPrecio(rs.getDouble("precio"));
        p.setStock(rs.getInt("stock"));
        p.setImagen(rs.getString("imagen"));
        p.setEstado(rs.getBoolean("estado"));
        p.setIdCategoria(rs.getLong("id_categoria"));
        return p;
    }

    @Override
    public List<Producto> listarTodos() {
        String sql = "SELECT * FROM producto";
        return jdbcTemplate.query(sql, this::mapRow);
    }

    @Override
    public Producto buscarPorId(Long id) {
        String sql = "SELECT * FROM producto WHERE id_producto = ?";
        return jdbcTemplate.query(sql, rs -> rs.next() ? mapRow(rs, 1) : null, id);
    }

    @Override
    public void guardar(Producto producto) {
        String sql = "INSERT INTO producto (nombre, descripcion, precio, stock, imagen, estado, id_categoria) VALUES (?, ?, ?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, producto.getNombre(), producto.getDescripcion(), producto.getPrecio(),
                producto.getStock(), producto.getImagen(), producto.getEstado(), producto.getIdCategoria());
    }

    @Override
    public void actualizar(Producto producto) {
        String sql = "UPDATE producto SET nombre = ?, descripcion = ?, precio = ?, stock = ?, imagen = ?, estado = ?, id_categoria = ? WHERE id_producto = ?";
        jdbcTemplate.update(sql, producto.getNombre(), producto.getDescripcion(), producto.getPrecio(),
                producto.getStock(), producto.getImagen(), producto.getEstado(), producto.getIdCategoria(),
                producto.getIdProducto());
    }

    @Override
    public void eliminar(Long id) {
        String sql = "DELETE FROM producto WHERE id_producto = ?";
        jdbcTemplate.update(sql, id);
    }
}
