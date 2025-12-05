package com.tienda_deportiva.repository;

import com.tienda_deportiva.model.Usuario;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.lang.NonNull;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class UsuarioRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final @NonNull RowMapper<Usuario> rowMapper = new RowMapper<Usuario>() {
        @Override
        public @NonNull Usuario mapRow(@NonNull ResultSet rs, int rowNum) throws SQLException {
            Usuario usuario = new Usuario();
            usuario.setId_usuario(rs.getInt("id_usuario"));
            usuario.setDni(rs.getString("dni"));
            usuario.setNombre_completo(rs.getString("nombre_completo"));
            usuario.setCorreo(rs.getString("correo"));
            usuario.setUsuario(rs.getString("usuario"));
            usuario.setContrasena(rs.getString("contrasena"));
            usuario.setCargo(rs.getString("cargo"));
            usuario.setEstado(rs.getBoolean("estado"));
            usuario.setHora_entrada(rs.getString("hora_entrada"));
            usuario.setHora_salida(rs.getString("hora_salida"));
            return usuario;
        }
    };

    public List<Usuario> findAll() {
        String sql = "SELECT * FROM usuario";
        return jdbcTemplate.query(sql, rowMapper);
    }

    public Usuario findById(Integer id) {
        String sql = "SELECT * FROM usuario WHERE id_usuario = ?";
        List<Usuario> usuarios = jdbcTemplate.query(sql, rowMapper, id);
        return usuarios.isEmpty() ? null : usuarios.get(0);
    }

    public int save(Usuario usuario) {
        String sql = "INSERT INTO usuario (dni, nombre_completo, correo, usuario, contrasena, cargo, estado, hora_entrada, hora_salida) "
                +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql,
                usuario.getDni(),
                usuario.getNombre_completo(),
                usuario.getCorreo(),
                usuario.getUsuario(),
                usuario.getContrasena(),
                usuario.getCargo(),
                usuario.getEstado(),
                usuario.getHora_entrada(),
                usuario.getHora_salida());
    }

    public int update(Usuario usuario) {
        String sql = "UPDATE usuario SET dni = ?, nombre_completo = ?, correo = ?, usuario = ?, " +
                "contrasena = ?, cargo = ?, estado = ?, hora_entrada = ?, hora_salida = ? WHERE id_usuario = ?";
        return jdbcTemplate.update(sql,
                usuario.getDni(),
                usuario.getNombre_completo(),
                usuario.getCorreo(),
                usuario.getUsuario(),
                usuario.getContrasena(),
                usuario.getCargo(),
                usuario.getEstado(),
                usuario.getHora_entrada(),
                usuario.getHora_salida(),
                usuario.getId_usuario());
    }

    public int delete(Integer id) {
        String sql = "DELETE FROM usuario WHERE id_usuario = ?";
        return jdbcTemplate.update(sql, id);
    }

    public Usuario findByUsuario(String usuario) {
        String sql = "SELECT * FROM usuario WHERE usuario = ?";
        List<Usuario> usuarios = jdbcTemplate.query(sql, rowMapper, usuario);
        return usuarios.isEmpty() ? null : usuarios.get(0);
    }

    public int countActivos() {
        String sql = "SELECT COUNT(*) FROM usuario WHERE estado = true AND cargo != 'Administrador'";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class);
        return count != null ? count : 0;
    }

    public boolean tieneVentasOAsistencias(Integer idUsuario) {
        // Verificar si tiene ventas
        String ventasSql = "SELECT COUNT(*) FROM venta WHERE id_usuario = ?";
        Integer ventasCount = jdbcTemplate.queryForObject(ventasSql, Integer.class, idUsuario);
        
        if (ventasCount != null && ventasCount > 0) {
            return true;
        }
        
        // Verificar si tiene asistencias
        String asistenciasSql = "SELECT COUNT(*) FROM asistencia WHERE id_usuario = ?";
        Integer asistenciasCount = jdbcTemplate.queryForObject(asistenciasSql, Integer.class, idUsuario);
        
        return asistenciasCount != null && asistenciasCount > 0;
    }
}