package com.tienda_deportiva.service;

import com.tienda_deportiva.model.Empleado;
import com.tienda_deportiva.repository.EmpleadoDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmpleadoServiceImpl implements EmpleadoService {

    @Autowired
    private EmpleadoDAO empleadoDAO;

    @Override
    public List<Empleado> listarTodos() {
        return empleadoDAO.listarTodos();
    }

    @Override
    public Empleado buscarPorId(Long id) {
        return empleadoDAO.buscarPorId(id);
    }

    @Override
    public void guardar(Empleado empleado) {
        empleadoDAO.guardar(empleado);
    }

    @Override
    public void actualizar(Empleado empleado) {
        empleadoDAO.actualizar(empleado);
    }

    @Override
    public void eliminar(Long id) {
        empleadoDAO.eliminar(id);
    }
}