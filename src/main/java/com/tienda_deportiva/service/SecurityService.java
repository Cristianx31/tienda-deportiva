package com.tienda_deportiva.service;

import com.tienda_deportiva.model.Usuario;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpSession;

/**
 * Servicio centralizado para validaciones de seguridad
 * Verifica que el usuario esté activo y tenga el rol correcto
 */
@Service
public class SecurityService {

    @Autowired
    private UsuarioService usuarioService;

    /**
     * Valida el acceso para un rol específico
     * @param session Sesión HTTP
     * @param rolEsperado Rol que se espera (ej: "Vendedor", "Administrador")
     * @param redirectAttributes Para pasar mensajes flash
     * @return null si la validación es exitosa, o una URL de redirección si falla
     */
    public String validarAcceso(HttpSession session, String rolEsperado, RedirectAttributes redirectAttributes) {
        Usuario usuarioActual = (Usuario) session.getAttribute("usuarioActual");
        
        // Validar que exista usuario en sesión
        if (usuarioActual == null) {
            return "redirect:/login";
        }
        
        // Obtener usuario actualizado de la BD para verificar estado y rol
        Usuario usuarioActualizado = usuarioService.buscarPorId(usuarioActual.getId_usuario());
        
        // Validar que el usuario siga existiendo en la BD
        if (usuarioActualizado == null) {
            session.invalidate();
            return "redirect:/login";
        }
        
        // VALIDAR 1: Si el usuario está INACTIVO, cerrar sesión
        if (!usuarioActualizado.getEstado()) {
            session.invalidate();
            if (redirectAttributes != null) {
                redirectAttributes.addFlashAttribute("error", "Tu cuenta ha sido desactivada. Contacta al administrador.");
            }
            return "redirect:/login";
        }
        
        // VALIDAR 2: Si el usuario NO TIENE EL ROL CORRECTO, cerrar sesión
        if (!rolEsperado.equals(usuarioActualizado.getCargo())) {
            session.invalidate();
            if (redirectAttributes != null) {
                redirectAttributes.addFlashAttribute("error", "Tu rol ha cambiado. Por favor, inicia sesión nuevamente.");
            }
            return "redirect:/login";
        }
        
        // Actualizar sesión con datos frescos de la BD
        session.setAttribute("usuarioActual", usuarioActualizado);
        
        return null; // Validación exitosa, continuar
    }

    /**
     * Valida acceso para Vendedor
     */
    public String validarVendedor(HttpSession session, RedirectAttributes redirectAttributes) {
        return validarAcceso(session, "Vendedor", redirectAttributes);
    }

    /**
     * Valida acceso para Administrador
     */
    public String validarAdmin(HttpSession session, RedirectAttributes redirectAttributes) {
        return validarAcceso(session, "Administrador", redirectAttributes);
    }
}
