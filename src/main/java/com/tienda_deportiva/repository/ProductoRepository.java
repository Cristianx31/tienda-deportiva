package com.tienda_deportiva.repository;

import com.tienda_deportiva.model.Producto;
import java.util.List;

public interface ProductoRepository {
    List<Producto> listarTodos();

    Producto buscarPorId(Long id);

    void guardar(Producto producto);

    void actualizar(Producto producto);

    void eliminar(Long id);

    boolean tieneVentasAsociadas(Long id);

    void desactivarPorCategoria(Long idCategoria);
}

