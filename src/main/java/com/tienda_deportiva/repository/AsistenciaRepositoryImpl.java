package com.tienda_deportiva.repository;

import com.tienda_deportiva.model.Asistencia;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

@Repository
public class AsistenciaRepositoryImpl implements AsistenciaRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private Asistencia mapRow(ResultSet rs, int rowNum) throws SQLException {
        Asistencia a = new Asistencia();
        a.setIdAsistencia(rs.getInt("id_asistencia"));
        a.setIdUsuario(rs.getInt("id_usuario"));
        a.setFecha(rs.getObject("fecha", java.time.LocalDate.class));
        a.setHoraIngreso(rs.getObject("hora_ingreso", java.time.LocalTime.class));
        a.setHoraSalida(rs.getObject("hora_salida", java.time.LocalTime.class));
        return a;
    }

    @Override
    public List<Asistencia> listarTodas() {
        String sql = "SELECT * FROM asistencia ORDER BY fecha DESC, id_asistencia DESC";
        return jdbcTemplate.query(sql, this::mapRow);
    }

    @Override
    public Asistencia buscarPorId(Integer id) {
        String sql = "SELECT * FROM asistencia WHERE id_asistencia = ?";
        return jdbcTemplate.query(sql, rs -> rs.next() ? mapRow(rs, 1) : null, id);
    }

    @Override
    public List<Asistencia> buscarPorIdUsuario(Integer idUsuario) {
        String sql = "SELECT * FROM asistencia WHERE id_usuario = ? ORDER BY fecha DESC, id_asistencia DESC";
        return jdbcTemplate.query(sql, this::mapRow, idUsuario);
    }
    
    @Override
    public Asistencia buscarPorUsuarioYFecha(Integer idUsuario, LocalDate fecha) {
        String sql = "SELECT * FROM asistencia WHERE id_usuario = ? AND fecha = ?";
        return jdbcTemplate.query(sql, rs -> rs.next() ? mapRow(rs, 1) : null, idUsuario, fecha);
    }

    @Override
    public void guardar(Asistencia asistencia) {
        String sql = "INSERT INTO asistencia (id_usuario, fecha, hora_ingreso, hora_salida) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql,
                asistencia.getIdUsuario(),
                asistencia.getFecha(),
                asistencia.getHoraIngreso(),
                asistencia.getHoraSalida()
        );
    }

    @Override
    public void actualizar(Asistencia asistencia) {
        String sql = "UPDATE asistencia SET id_usuario = ?, fecha = ?, hora_ingreso = ?, hora_salida = ? WHERE id_asistencia = ?";
        jdbcTemplate.update(sql,
                asistencia.getIdUsuario(),
                asistencia.getFecha(),
                asistencia.getHoraIngreso(),
                asistencia.getHoraSalida(),
                asistencia.getIdAsistencia()
        );
    }

    @Override
    public void eliminar(Integer id) {
        String sql = "DELETE FROM asistencia WHERE id_asistencia = ?";
        jdbcTemplate.update(sql, id);
    }
}
