package com.tienda_deportiva.service;

import com.tienda_deportiva.model.Asistencia;
import com.tienda_deportiva.repository.AsistenciaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class AsistenciaServiceImpl implements AsistenciaService {

    @Autowired
    private AsistenciaRepository asistenciaRepository;

    @Override
    public List<Asistencia> listarTodas() {
        return asistenciaRepository.listarTodas();
    }

    @Override
    public Asistencia buscarPorId(Integer id) {
        return asistenciaRepository.buscarPorId(id);
    }

    @Override
    public List<Asistencia> buscarPorIdUsuario(Integer idUsuario) {
        return asistenciaRepository.buscarPorIdUsuario(idUsuario);
    }

    @Override
    public Asistencia buscarPorUsuarioYFecha(Integer idUsuario, LocalDate fecha) {
        return asistenciaRepository.buscarPorUsuarioYFecha(idUsuario, fecha);
    }

    @Override
    public void guardar(Asistencia asistencia) {
        asistenciaRepository.guardar(asistencia);
    }

    @Override
    public void actualizar(Asistencia asistencia) {
        asistenciaRepository.actualizar(asistencia);
    }

    @Override
    public void eliminar(Integer id) {
        asistenciaRepository.eliminar(id);
    }
}
