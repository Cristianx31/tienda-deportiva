package com.tienda_deportiva.repository;

import com.tienda_deportiva.model.Categoria;
import java.util.List;

public interface CategoriaRepository {
    List<Categoria> listarTodas();

    Categoria buscarPorId(Long id);

    void guardar(Categoria categoria);

    void actualizar(Categoria categoria);

    void eliminar(Long id);
}
