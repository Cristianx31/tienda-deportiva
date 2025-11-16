package com.tienda_deportiva.service;

import com.tienda_deportiva.model.Asistencia;
import java.util.List;

public interface AsistenciaService {
    List<Asistencia> listarTodas();

    Asistencia buscarPorId(Integer id);

    List<Asistencia> buscarPorIdUsuario(Integer idUsuario);

    void guardar(Asistencia asistencia);

    void actualizar(Asistencia asistencia);

    void eliminar(Integer id);
}
