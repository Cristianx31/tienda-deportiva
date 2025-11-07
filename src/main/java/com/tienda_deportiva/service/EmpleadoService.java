package com.tienda_deportiva.service;

import com.tienda_deportiva.model.Empleado;
import java.util.List;

public interface EmpleadoService {
    List<Empleado> listarTodos();

    Empleado buscarPorId(Long id);

    void guardar(Empleado empleado);

    void actualizar(Empleado empleado);

    void eliminar(Long id);

    boolean tieneVentasOAsistencias(Long id);
}
