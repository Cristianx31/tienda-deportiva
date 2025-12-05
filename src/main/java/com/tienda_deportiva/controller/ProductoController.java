package com.tienda_deportiva.controller;

import com.tienda_deportiva.model.Producto;
import com.tienda_deportiva.service.ProductoService;
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
public class ProductoController {

    @Autowired
    private ProductoService productoService;

    @Autowired
    private CategoriaService categoriaService;

    @Autowired
    private SecurityService securityService;

    @GetMapping("/producto-crear")
    public String mostrarFormularioCrear(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarAdmin(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        model.addAttribute("producto", new Producto());
        model.addAttribute("categorias", categoriaService.listarTodas());
        return "admin/producto-crear";
    }

    @PostMapping("/producto-crear")
    public String crearProducto(HttpSession session, @ModelAttribute Producto producto, @RequestParam Boolean estado,
            @RequestParam Long idCategoria, RedirectAttributes redirectAttributes) {
        
        String validacion = securityService.validarAdmin(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        // Validación: nombre obligatorio
        if (producto.getNombre() == null || producto.getNombre().trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "El nombre del producto es obligatorio.");
            return "redirect:/admin/producto-crear";
        }

        var categoria = categoriaService.buscarPorId(idCategoria);
        if (categoria == null || !categoria.getEstado()) {
            redirectAttributes.addFlashAttribute("error",
                    "No se puede crear un producto en una categoría inactiva.");
            return "redirect:/admin/producto-crear";
        }

        if (producto.getPrecio() == null || producto.getPrecio() <= 0) {
            redirectAttributes.addFlashAttribute("error", "El precio debe ser mayor a 0.");
            return "redirect:/admin/producto-crear";
        }

        producto.setIdCategoria(idCategoria);
        producto.setEstado(true); // Todo producto nuevo se registra con estado = activo
        productoService.guardar(producto);
        redirectAttributes.addFlashAttribute("success", "Producto creado exitosamente.");
        return "redirect:/admin/gestion?tab=productos";
    }

    @GetMapping("/producto-editar/{id}")
    public String mostrarFormularioEditar(HttpSession session, @PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        String validacion = securityService.validarAdmin(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        model.addAttribute("producto", productoService.buscarPorId(id));
        model.addAttribute("categorias", categoriaService.listarTodas());
        return "admin/producto-editar";
    }

    @PostMapping("/producto-editar")
    public String editarProducto(HttpSession session, @ModelAttribute Producto producto, @RequestParam Boolean estado,
            @RequestParam Long idCategoria, RedirectAttributes redirectAttributes) {
        
        String validacion = securityService.validarAdmin(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        var productoActual = productoService.buscarPorId(producto.getIdProducto());
        if (!productoActual.getIdCategoria().equals(idCategoria)) {
            var categoria = categoriaService.buscarPorId(idCategoria);
            if (categoria == null || !categoria.getEstado()) {
                redirectAttributes.addFlashAttribute("error",
                        "No se puede cambiar a una categoría inactiva.");
                return "redirect:/admin/producto-editar/" + producto.getIdProducto();
            }
        }

        if (producto.getPrecio() == null || producto.getPrecio() <= 0) {
            redirectAttributes.addFlashAttribute("error", "El precio debe ser mayor a 0.");
            return "redirect:/admin/producto-editar/" + producto.getIdProducto();
        }

        producto.setIdCategoria(idCategoria);
        producto.setEstado(estado);
        productoService.actualizar(producto);
        redirectAttributes.addFlashAttribute("success", "Producto actualizado exitosamente.");
        return "redirect:/admin/gestion?tab=productos";
    }

    @GetMapping("/producto-eliminar/{id}")
    public String eliminarProducto(HttpSession session, @PathVariable Long id, RedirectAttributes redirectAttributes) {
        
        String validacion = securityService.validarAdmin(session, redirectAttributes);
        if (validacion != null)
            return validacion;

        if (productoService.tieneVentasAsociadas(id)) {
            redirectAttributes.addFlashAttribute("error",
                    "No se puede eliminar el producto porque tiene ventas asociadas. Solo puede desactivarse.");
            return "redirect:/admin/gestion?tab=productos";
        }

        productoService.eliminar(id);
        redirectAttributes.addFlashAttribute("success", "Producto eliminado exitosamente.");
        return "redirect:/admin/gestion?tab=productos";
    }
}
