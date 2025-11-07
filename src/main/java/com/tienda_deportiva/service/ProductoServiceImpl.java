package com.tienda_deportiva.service;

import com.tienda_deportiva.model.Producto;
import com.tienda_deportiva.repository.ProductoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductoServiceImpl implements ProductoService {

    @Autowired
    private ProductoRepository productoRepository;

    @Override
    public List<Producto> listarTodos() {
        return productoRepository.listarTodos();
    }

    @Override
    public Producto buscarPorId(Long id) {
        return productoRepository.buscarPorId(id);
    }

    @Override
    public void guardar(Producto producto) {
        productoRepository.guardar(producto);
    }

    @Override
    public void actualizar(Producto producto) {
        productoRepository.actualizar(producto);
    }

    @Override
    public void eliminar(Long id) {
        productoRepository.eliminar(id);
    }

    @Override
    public boolean tieneVentasAsociadas(Long id) {
        return productoRepository.tieneVentasAsociadas(id);
    }
}
