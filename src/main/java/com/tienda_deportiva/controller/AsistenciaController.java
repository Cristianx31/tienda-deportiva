package com.tienda_deportiva.controller;

import com.tienda_deportiva.service.AsistenciaService;
import com.tienda_deportiva.model.Asistencia;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin/asistencia")
public class AsistenciaController {
    
    @Autowired
    private AsistenciaService asistenciaService;
    
    @GetMapping("/listar")
    public String listarAsistencias(Model model) {
        List<Asistencia> asistencias = asistenciaService.listarTodas();
        model.addAttribute("asistencias", asistencias);
        return "admin/asistencia/listar";
    }
    
    @GetMapping("/detalle/{id}")
    public String detalleAsistencia(@PathVariable Integer id, Model model) {
        Asistencia asistencia = asistenciaService.buscarPorId(id);
        model.addAttribute("asistencia", asistencia);
        return "admin/asistencia/detalle";
    }
    
    @GetMapping("/usuario/{idUsuario}")
    public String asistenciasPorUsuario(@PathVariable Integer idUsuario, Model model) {
        List<Asistencia> asistencias = asistenciaService.buscarPorIdUsuario(idUsuario);
        model.addAttribute("asistencias", asistencias);
        model.addAttribute("idUsuario", idUsuario);
        return "admin/asistencia/por-usuario";
    }
    
    @PostMapping("/eliminar/{id}")
    public String eliminarAsistencia(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
        try {
            asistenciaService.eliminar(id);
            redirectAttributes.addFlashAttribute("success", "Asistencia eliminada correctamente");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error al eliminar la asistencia");
        }
        return "redirect:/admin/asistencia/listar";
    }
}
