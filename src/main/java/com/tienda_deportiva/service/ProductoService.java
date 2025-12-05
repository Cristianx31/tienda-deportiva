package com.tienda_deportiva.service;

import com.tienda_deportiva.model.Producto;
import java.util.List;

public interface ProductoService {
    List<Producto> listarTodos();

    Producto buscarPorId(Long id);

    void guardar(Producto producto);

    void actualizar(Producto producto);

    void eliminar(Long id);

    boolean tieneVentasAsociadas(Long id);
}
