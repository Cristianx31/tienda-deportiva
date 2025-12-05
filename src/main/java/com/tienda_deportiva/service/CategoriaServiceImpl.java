package com.tienda_deportiva.service;

import com.tienda_deportiva.model.Categoria;
import com.tienda_deportiva.repository.CategoriaRepository;
import com.tienda_deportiva.repository.ProductoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoriaServiceImpl implements CategoriaService {

    @Autowired
    private CategoriaRepository categoriaRepository;

    @Autowired
    private ProductoRepository productoRepository;

    @Override
    public List<Categoria> listarTodas() {
        return categoriaRepository.listarTodas();
    }

    @Override
    public Categoria buscarPorId(Long id) {
        return categoriaRepository.buscarPorId(id);
    }

    @Override
    public void guardar(Categoria categoria) {
        categoriaRepository.guardar(categoria);
    }

    @Override
    public void actualizar(Categoria categoria) {
        categoriaRepository.actualizar(categoria);
    }

    @Override
    public void eliminar(Long id) {
        categoriaRepository.eliminar(id);
    }

    @Override
    public boolean tieneProductosAsociados(Long id) {
        return categoriaRepository.tieneProductosAsociados(id);
    }

    @Override
    public boolean tieneVentasAsociadas(Long id) {
        return categoriaRepository.tieneVentasAsociadas(id);
    }

    @Override
    public void desactivarProductosAsociados(Long idCategoria) {
        productoRepository.desactivarPorCategoria(idCategoria);
    }
}

