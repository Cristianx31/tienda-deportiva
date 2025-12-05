package com.tienda_deportiva.controller;

import com.tienda_deportiva.model.Categoria;
import com.tienda_deportiva.service.CategoriaService;
import com.tienda_deportiva.service.SecurityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class CategoriaController {

    @Autowired
    private CategoriaService categoriaService;

    @Autowired
    private SecurityService securityService;

    @GetMapping("/categoria-crear")
    public String mostrarFormularioCrear(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarAdmin(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        model.addAttribute("categoria", new Categoria());
        return "admin/categoria-crear";
    }

    @PostMapping("/categoria-crear")
    public String crearCategoria(HttpSession session, @ModelAttribute Categoria categoria, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarAdmin(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        categoriaService.guardar(categoria);
        return "redirect:/admin/gestion?tab=categorias";
    }

    @GetMapping("/categoria-editar/{id}")
    public String mostrarFormularioEditar(HttpSession session, @PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarAdmin(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        model.addAttribute("categoria", categoriaService.buscarPorId(id));
        return "admin/categoria-editar";
    }

    @PostMapping("/categoria-editar")
    public String editarCategoria(HttpSession session, @ModelAttribute Categoria categoria, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarAdmin(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        Categoria existente = categoriaService.buscarPorId(categoria.getIdCategoria());
        if (existente != null && !categoria.getEstado().equals(existente.getEstado())) {

            if (categoriaService.tieneVentasAsociadas(categoria.getIdCategoria())) {
                redirectAttributes.addFlashAttribute("errorCategoria",
                        "No se puede cambiar el estado: la categoría tiene ventas asociadas.");
                return "redirect:/admin/gestion?tab=categorias";
            }

            // Si la categoría se está desactivando, desactivar todos sus productos
            if (!categoria.getEstado()) {
                categoriaService.desactivarProductosAsociados(categoria.getIdCategoria());
            }
        }

        categoriaService.actualizar(categoria);
        redirectAttributes.addFlashAttribute("successCategoria", "Categoría actualizada correctamente.");
        return "redirect:/admin/gestion?tab=categorias";
    }

    @GetMapping("/categoria-eliminar/{id}")
    public String eliminarCategoria(HttpSession session, @PathVariable Long id, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarAdmin(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        if (categoriaService.tieneProductosAsociados(id)) {
            redirectAttributes.addFlashAttribute("errorCategoria",
                    "No se puede eliminar la categoría porque tiene productos asociados.");
            return "redirect:/admin/gestion?tab=categorias";
        }

        if (categoriaService.tieneVentasAsociadas(id)) {
            redirectAttributes.addFlashAttribute("errorCategoria",
                    "No se puede eliminar la categoría porque tiene ventas asociadas.");
            return "redirect:/admin/gestion?tab=categorias";
        }

        categoriaService.eliminar(id);
        redirectAttributes.addFlashAttribute("successCategoria", "Categoría eliminada exitosamente.");
        return "redirect:/admin/gestion?tab=categorias";
    }
}
