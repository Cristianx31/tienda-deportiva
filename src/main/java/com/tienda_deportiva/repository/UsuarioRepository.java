package com.tienda_deportiva.repository;

import com.tienda_deportiva.model.Usuario;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class UsuarioRepository {

    private final JdbcTemplate jdbcTemplate;

    public UsuarioRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

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

    public List<Usuario> findAll() {
        return jdbcTemplate.query("SELECT * FROM usuario", usuarioMapper);
    }

    public int save(Usuario usuario) {
        return jdbcTemplate.update(
                "INSERT INTO usuario (dni, nombre_completo, correo, usuario, contrasena, cargo, estado) VALUES (?, ?, ?, ?, ?, ?, ?)",
                usuario.getDni(), usuario.getNombre_completo(), usuario.getCorreo(),
                usuario.getUsuario(), usuario.getContrasena(), usuario.getCargo(), usuario.getEstado());
    }
}