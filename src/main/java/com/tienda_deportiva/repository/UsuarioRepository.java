package com.tienda_deportiva.repository;

import com.tienda_deportiva.model.Usuario;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class UsuarioRepository {

    private final JdbcTemplate jdbcTemplate;

    public UsuarioRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @NonNull
    private RowMapper<Usuario> usuarioMapper = (rs, rowNum) -> {
        Usuario u = new Usuario();
        u.setId_usuario(rs.getInt("id_usuario"));
        u.setDni(rs.getString("dni"));
        u.setNombre_completo(rs.getString("nombre_completo"));
        u.setCorreo(rs.getString("correo"));
        u.setUsuario(rs.getString("usuario"));
        u.setContrasena(rs.getString("contrasena"));
        u.setCargo(rs.getString("cargo"));
        u.setEstado(rs.getBoolean("estado"));
        return u;
    };

    public List<Usuario> listarTodos() {
        return jdbcTemplate.query("SELECT * FROM usuario", usuarioMapper);
    }

    public int guardar(Usuario usuario) {
        return jdbcTemplate.update(
                "INSERT INTO usuario (dni, nombre_completo, correo, usuario, contrasena, cargo, estado) VALUES (?, ?, ?, ?, ?, ?, ?)",
                usuario.getDni(), usuario.getNombre_completo(), usuario.getCorreo(), usuario.getUsuario(),
                usuario.getContrasena(), usuario.getCargo(), usuario.getEstado());
    }

    public Usuario buscarPorUsuarioYContrasena(String usuario, String contrasena) {
        String sql = "SELECT * FROM usuario WHERE usuario = ? AND contrasena = ?";
        List<Usuario> usuarios = jdbcTemplate.query(sql, usuarioMapper, usuario, contrasena);
        return usuarios.isEmpty() ? null : usuarios.get(0);
    }

    public boolean tieneVentasOAsistencias(int idUsuario) {
        // Verificar si tiene ventas
        String sqlVentas = "SELECT COUNT(*) FROM venta WHERE id_usuario = ?";
        Integer countVentas = jdbcTemplate.queryForObject(sqlVentas, Integer.class, idUsuario);
        
        // Verificar si tiene asistencias
        String sqlAsistencias = "SELECT COUNT(*) FROM asistencia WHERE id_usuario = ?";
        Integer countAsistencias = jdbcTemplate.queryForObject(sqlAsistencias, Integer.class, idUsuario);
        
        return (countVentas != null && countVentas > 0) || (countAsistencias != null && countAsistencias > 0);
    }
}