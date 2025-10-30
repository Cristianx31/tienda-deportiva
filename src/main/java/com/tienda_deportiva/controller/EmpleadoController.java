package com.tienda_deportiva.controller;

import com.tienda_deportiva.model.Empleado;
import com.tienda_deportiva.service.EmpleadoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin")
public class EmpleadoController {

    @Autowired
    private EmpleadoService empleadoService;

    // Mostrar formulario de creación
    @GetMapping("/empleado-crear")
    public String mostrarFormularioCrear(Model model) {
        model.addAttribute("empleado", new Empleado());
        return "admin/empleado-crear";
    }

    // Guardar nuevo empleado
    @PostMapping("/empleado-crear")
    public String crearEmpleado(@ModelAttribute Empleado empleado) {
        empleado.setEstado(true);
        empleadoService.guardar(empleado);
        return "redirect:/admin/gestion";
    }

    // Mostrar formulario de edición
    @GetMapping("/empleado-editar/{id}")
    public String mostrarFormularioEditar(@PathVariable Long id, Model model) {
        model.addAttribute("empleado", empleadoService.buscarPorId(id));
        return "admin/empleado-editar";
    }

    // Guardar cambios de edición
    @PostMapping("/empleado-editar")
    public String editarEmpleado(@ModelAttribute Empleado empleado, @RequestParam String estado) {
        empleado.setEstado(Boolean.valueOf(estado));
        empleadoService.actualizar(empleado);
        return "redirect:/admin/gestion";
    }

    // Eliminar empleado
    @GetMapping("/empleado-eliminar/{id}")
    public String eliminarEmpleado(@PathVariable Long id) {
        empleadoService.eliminar(id);
        return "redirect:/admin/gestion";
    }
}