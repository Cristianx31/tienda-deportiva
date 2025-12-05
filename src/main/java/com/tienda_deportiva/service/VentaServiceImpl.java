package com.tienda_deportiva.service;

import com.tienda_deportiva.model.Venta;
import com.tienda_deportiva.model.DetalleVenta;
import com.tienda_deportiva.repository.VentaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class VentaServiceImpl implements VentaService {

    @Autowired
    private VentaRepository ventaRepository;

    @Override
    public List<Venta> listarTodas() {
        return ventaRepository.listarTodas();
    }

    @Override
    public List<Venta> listarPorUsuario(Long idUsuario) {
        return ventaRepository.listarPorUsuario(idUsuario);
    }

    @Override
    public Venta buscarPorId(Long id) {
        return ventaRepository.buscarPorId(id);
    }

    @Override
    public List<DetalleVenta> buscarDetallesPorVenta(Long idVenta) {
        return ventaRepository.buscarDetallesPorVenta(idVenta);
    }

    @Override
    public Long guardar(Venta venta) {
        return ventaRepository.guardar(venta);
    }

    @Override
    public void guardarDetalle(DetalleVenta detalle) {
        ventaRepository.guardarDetalle(detalle);
    }

    @Override
    public Long guardarCliente(String nombre, String dni) {
        return ventaRepository.guardarCliente(nombre, dni);
    }

    @Override
    public Map<String, Object> obtenerMetricasGenerales() {
        return ventaRepository.obtenerMetricasGenerales();
    }

    @Override
    public List<Map<String, Object>> obtenerVentasMensuales() {
        return ventaRepository.obtenerVentasMensuales();
    }

    @Override
    public List<Map<String, Object>> obtenerVentasDiarias() {
        return ventaRepository.obtenerVentasDiarias();
    }

    @Override
    public List<Map<String, Object>> obtenerAsistenciaMensual() {
        return ventaRepository.obtenerAsistenciaMensual();
    }

    @Override
    public List<Map<String, Object>> obtenerVentasDiarias30Dias() {
        return ventaRepository.obtenerVentasDiarias30Dias();
    }

    @Override
    public List<Map<String, Object>> obtenerAsistenciaSemanal() {
        return ventaRepository.obtenerAsistenciaSemanal();
    }

    @Override
    public List<Map<String, Object>> obtenerVentasPorCategoria6Meses() {
        return ventaRepository.obtenerVentasPorCategoria6Meses();
    }
}
