package com.tienda_deportiva.service;

import com.tienda_deportiva.model.Categoria;
import java.util.List;

public interface CategoriaService {
    List<Categoria> listarTodas();

    Categoria buscarPorId(Long id);

    void guardar(Categoria categoria);

    void actualizar(Categoria categoria);

    void eliminar(Long id);

    boolean tieneProductosAsociados(Long id);

    boolean tieneVentasAsociadas(Long id);

    void desactivarProductosAsociados(Long idCategoria);
}

