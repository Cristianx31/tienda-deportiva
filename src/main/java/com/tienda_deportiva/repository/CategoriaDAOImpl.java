package com.tienda_deportiva.repository;

import com.tienda_deportiva.model.Categoria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class CategoriaDAOImpl implements CategoriaRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private Categoria mapRow(ResultSet rs, int rowNum) throws SQLException {
        Categoria c = new Categoria();
        c.setIdCategoria(rs.getLong("id_categoria"));
        c.setNombre(rs.getString("nombre"));
        c.setEstado(rs.getBoolean("estado"));
        return c;
    }

    @Override
    public List<Categoria> listarTodas() {
        String sql = "SELECT * FROM categoria";
        return jdbcTemplate.query(sql, this::mapRow);
    }

    @Override
    public Categoria buscarPorId(Long id) {
        String sql = "SELECT * FROM categoria WHERE id_categoria = ?";
        return jdbcTemplate.query(sql, rs -> rs.next() ? mapRow(rs, 1) : null, id);
    }

    @Override
    public void guardar(Categoria categoria) {
        String sql = "INSERT INTO categoria (nombre, estado) VALUES (?, ?)";
        jdbcTemplate.update(sql, categoria.getNombre(), categoria.getEstado());
    }

    @Override
    public void actualizar(Categoria categoria) {
        String sql = "UPDATE categoria SET nombre = ?, estado = ? WHERE id_categoria = ?";
        jdbcTemplate.update(sql, categoria.getNombre(), categoria.getEstado(), categoria.getIdCategoria());
    }

    @Override
    public void eliminar(Long id) {
        String sql = "DELETE FROM categoria WHERE id_categoria = ?";
        jdbcTemplate.update(sql, id);
    }
}
