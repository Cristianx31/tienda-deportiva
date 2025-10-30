package com.tienda_deportiva.repository;

import com.tienda_deportiva.model.Empleado;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class EmpleadoDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private Empleado mapEmpleado(ResultSet rs) throws SQLException {
        Empleado e = new Empleado();
        e.setId(rs.getLong("id_usuario"));
        e.setDni(rs.getString("dni"));
        e.setNombreCompleto(rs.getString("nombre_completo"));
        e.setCargo(rs.getString("cargo"));
        e.setCorreo(rs.getString("correo"));
        e.setUsuario(rs.getString("usuario"));
        e.setContrasena(rs.getString("contrasena"));
        e.setEstado(rs.getBoolean("estado"));
        return e;
    }

    public List<Empleado> listarTodos() {
        String sql = "SELECT * FROM usuario";
        return jdbcTemplate.query(sql, (rs, rowNum) -> mapEmpleado(rs));
    }

    public Empleado buscarPorId(Long id) {
        String sql = "SELECT * FROM usuario WHERE id_usuario = ?";
        List<Empleado> lista = jdbcTemplate.query(sql, (rs, rowNum) -> mapEmpleado(rs), id);
        return lista.isEmpty() ? null : lista.get(0);
    }

    public void guardar(Empleado empleado) {
        String sql = "INSERT INTO usuario (dni, nombre_completo, cargo, correo, usuario, contrasena, estado) VALUES (?, ?, ?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, empleado.getDni(), empleado.getNombreCompleto(), empleado.getCargo(),
                empleado.getCorreo(), empleado.getUsuario(), empleado.getContrasena(), empleado.getEstado());
    }

    public void actualizar(Empleado empleado) {
        String sql = "UPDATE usuario SET dni=?, nombre_completo=?, cargo=?, correo=?, usuario=?, contrasena=?, estado=? WHERE id_usuario=?";
        jdbcTemplate.update(sql, empleado.getDni(), empleado.getNombreCompleto(), empleado.getCargo(),
                empleado.getCorreo(), empleado.getUsuario(), empleado.getContrasena(), empleado.getEstado(),
                empleado.getId());
    }

    public void eliminar(Long id) {
        String sql = "DELETE FROM usuario WHERE id_usuario = ?";
        jdbcTemplate.update(sql, id);
    }
}