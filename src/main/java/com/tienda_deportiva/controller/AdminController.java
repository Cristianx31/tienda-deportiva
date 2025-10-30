package com.tienda_deportiva.controller;

import com.tienda_deportiva.service.EmpleadoService;
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

    @GetMapping("/gestion")
    public String gestion(Model model) {
        model.addAttribute("empleados", empleadoService.listarTodos());
        // Aquí puedes agregar productos, ventas, etc. cuando los tengas
        return "admin/gestion";
    }
}
