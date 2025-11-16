package com.tienda_deportiva.controller;

import com.tienda_deportiva.model.Categoria;
import com.tienda_deportiva.service.CategoriaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin")
public class CategoriaController {

    @Autowired
    private CategoriaService categoriaService;

    @GetMapping("/categoria-crear")
    public String mostrarFormularioCrear(Model model) {
        model.addAttribute("categoria", new Categoria());
        return "admin/categoria-crear";
    }

    @PostMapping("/categoria-crear")
    public String crearCategoria(@ModelAttribute Categoria categoria) {
        categoriaService.guardar(categoria);
        return "redirect:/admin/gestion?tab=categorias";
    }

    @GetMapping("/categoria-editar/{id}")
    public String mostrarFormularioEditar(@PathVariable Long id, Model model) {
        model.addAttribute("categoria", categoriaService.buscarPorId(id));
        return "admin/categoria-editar";
    }

    @PostMapping("/categoria-editar")
    public String editarCategoria(@ModelAttribute Categoria categoria) {
        categoriaService.actualizar(categoria);
        return "redirect:/admin/gestion?tab=categorias";
    }

    @GetMapping("/categoria-eliminar/{id}")
    public String eliminarCategoria(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        // Verificar si la categoría tiene productos asociados
        if (categoriaService.tieneProductosAsociados(id)) {
            redirectAttributes.addFlashAttribute("errorCategoria", 
                "No se puede eliminar la categoría porque tiene productos asociados.");
            return "redirect:/admin/gestion?tab=categorias";
        }
        
        categoriaService.eliminar(id);
        redirectAttributes.addFlashAttribute("successCategoria", "Categoría eliminada exitosamente.");
        return "redirect:/admin/gestion?tab=categorias";
    }
}
