package com.tienda_deportiva.controller;

import com.tienda_deportiva.service.AsistenciaService;
import com.tienda_deportiva.service.SecurityService;
import com.tienda_deportiva.model.Asistencia;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpSession;

import java.util.List;

@Controller
@RequestMapping("/admin/asistencia")
public class AsistenciaController {

    @Autowired
    private AsistenciaService asistenciaService;

    @Autowired
    private SecurityService securityService;

    @GetMapping("/listar")
    public String listarAsistencias(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarAdmin(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        List<Asistencia> asistencias = asistenciaService.listarTodas();
        model.addAttribute("asistencias", asistencias);
        return "admin/asistencia/listar";
    }

    @GetMapping("/detalle/{id}")
    public String detalleAsistencia(HttpSession session, @PathVariable Integer id, Model model, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarAdmin(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        Asistencia asistencia = asistenciaService.buscarPorId(id);
        model.addAttribute("asistencia", asistencia);
        return "admin/asistencia/detalle";
    }

    @GetMapping("/usuario/{idUsuario}")
    public String asistenciasPorUsuario(HttpSession session, @PathVariable Integer idUsuario, Model model, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarAdmin(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        List<Asistencia> asistencias = asistenciaService.buscarPorIdUsuario(idUsuario);
        model.addAttribute("asistencias", asistencias);
        model.addAttribute("idUsuario", idUsuario);
        return "admin/asistencia/por-usuario";
    }

    @PostMapping("/eliminar/{id}")
    public String eliminarAsistencia(HttpSession session, @PathVariable Integer id, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarAdmin(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        redirectAttributes.addFlashAttribute("error", 
            "No se puede eliminar registros de asistencia. Los registros de asistencia son permanentes.");
        return "redirect:/admin/asistencia/listar";
    }
}
