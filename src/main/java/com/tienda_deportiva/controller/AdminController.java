package com.tienda_deportiva.controller;

import com.tienda_deportiva.service.EmpleadoService;
import com.tienda_deportiva.service.CategoriaService; // <-- Importa el servicio
import com.tienda_deportiva.service.ProductoService; // <-- Importa el servicio
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private EmpleadoService empleadoService;

    @Autowired
    private CategoriaService categoriaService;

    @Autowired
    private ProductoService productoService;

    @GetMapping("/gestion")
    public String gestion(Model model) {
        model.addAttribute("empleados", empleadoService.listarTodos());
        model.addAttribute("categorias", categoriaService.listarTodas());
        model.addAttribute("productos", productoService.listarTodos());
        return "admin/gestion";
    }
}
