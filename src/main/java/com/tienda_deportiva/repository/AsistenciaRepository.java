package com.tienda_deportiva.repository;

import com.tienda_deportiva.model.Asistencia;
import java.time.LocalDate;
import java.util.List;

public interface AsistenciaRepository {
    List<Asistencia> listarTodas();

    Asistencia buscarPorId(Integer id);

    List<Asistencia> buscarPorIdUsuario(Integer idUsuario);
    
    Asistencia buscarPorUsuarioYFecha(Integer idUsuario, LocalDate fecha);

    void guardar(Asistencia asistencia);

    void actualizar(Asistencia asistencia);

    void eliminar(Integer id);
}
