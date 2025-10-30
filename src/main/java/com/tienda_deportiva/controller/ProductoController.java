package com.tienda_deportiva.controller;

import com.tienda_deportiva.model.Producto;
import com.tienda_deportiva.service.ProductoService;
import com.tienda_deportiva.service.CategoriaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin")
public class ProductoController {

    @Autowired
    private ProductoService productoService;

    @Autowired
    private CategoriaService categoriaService;

    @GetMapping("/producto-crear")
    public String mostrarFormularioCrear(Model model) {
        model.addAttribute("producto", new Producto());
        model.addAttribute("categorias", categoriaService.listarTodas());
        return "admin/producto-crear";
    }

    @PostMapping("/producto-crear")
    public String crearProducto(@ModelAttribute Producto producto, @RequestParam Boolean estado) {
        producto.setEstado(estado);
        productoService.guardar(producto);
        return "redirect:/admin/gestion";
    }

    @GetMapping("/producto-editar/{id}")
    public String mostrarFormularioEditar(@PathVariable Long id, Model model) {
        model.addAttribute("producto", productoService.buscarPorId(id));
        model.addAttribute("categorias", categoriaService.listarTodas());
        return "admin/producto-editar";
    }

    @PostMapping("/producto-editar")
    public String editarProducto(@ModelAttribute Producto producto, @RequestParam Boolean estado) {
        producto.setEstado(estado);
        productoService.actualizar(producto);
        return "redirect:/admin/gestion";
    }

    @GetMapping("/producto-eliminar/{id}")
    public String eliminarProducto(@PathVariable Long id) {
        productoService.eliminar(id);
        return "redirect:/admin/gestion";
    }
}
