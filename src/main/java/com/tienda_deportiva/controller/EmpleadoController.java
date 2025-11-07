package com.tienda_deportiva.controller;

import com.tienda_deportiva.model.Empleado;
import com.tienda_deportiva.service.EmpleadoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
    public String crearEmpleado(@ModelAttribute Empleado empleado,
                                @RequestParam String horaEntrada,
                                @RequestParam String horaSalida) {
        empleado.setEstado(true);
        
        // Convertir formato HH:mm a HH:mm:ss para Time.valueOf()
        try {
            if (horaEntrada != null && !horaEntrada.isEmpty()) {
                empleado.setHoraEntrada(java.sql.Time.valueOf(horaEntrada + ":00"));
            } else {
                empleado.setHoraEntrada(java.sql.Time.valueOf("08:00:00"));
            }
            
            if (horaSalida != null && !horaSalida.isEmpty()) {
                empleado.setHoraSalida(java.sql.Time.valueOf(horaSalida + ":00"));
            } else {
                empleado.setHoraSalida(java.sql.Time.valueOf("17:00:00"));
            }
        } catch (Exception e) {
            // Si hay error, usar valores por defecto
            empleado.setHoraEntrada(java.sql.Time.valueOf("08:00:00"));
            empleado.setHoraSalida(java.sql.Time.valueOf("17:00:00"));
        }
        
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
    public String editarEmpleado(@ModelAttribute Empleado empleado, 
                                 @RequestParam String estado,
                                 @RequestParam String horaEntrada,
                                 @RequestParam String horaSalida) {
        empleado.setEstado(Boolean.valueOf(estado));
        
        // Convertir formato HH:mm a HH:mm:ss para Time.valueOf()
        try {
            if (horaEntrada != null && !horaEntrada.isEmpty()) {
                empleado.setHoraEntrada(java.sql.Time.valueOf(horaEntrada + ":00"));
            }
            if (horaSalida != null && !horaSalida.isEmpty()) {
                empleado.setHoraSalida(java.sql.Time.valueOf(horaSalida + ":00"));
            }
        } catch (Exception e) {
            // Si hay error, usar valores por defecto
            empleado.setHoraEntrada(java.sql.Time.valueOf("08:00:00"));
            empleado.setHoraSalida(java.sql.Time.valueOf("17:00:00"));
        }
        
        empleadoService.actualizar(empleado);
        return "redirect:/admin/gestion";
    }

    // Eliminar empleado
    @GetMapping("/empleado-eliminar/{id}")
    public String eliminarEmpleado(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        // Verificar si el empleado tiene ventas o asistencias asociadas
        if (empleadoService.tieneVentasOAsistencias(id)) {
            redirectAttributes.addFlashAttribute("errorEmpleado", 
                "No se puede eliminar el empleado porque tiene ventas o asistencias registradas.");
            return "redirect:/admin/gestion";
        }
        
        empleadoService.eliminar(id);
        redirectAttributes.addFlashAttribute("successEmpleado", "Empleado eliminado exitosamente.");
        return "redirect:/admin/gestion";
    }
}