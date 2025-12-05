package com.tienda_deportiva.service;

import com.tienda_deportiva.model.Usuario;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpSession;

@Service
public class SecurityService {

    @Autowired
    private UsuarioService usuarioService;

    public String validarAcceso(HttpSession session, String rolEsperado, RedirectAttributes redirectAttributes) {
        Usuario usuarioActual = (Usuario) session.getAttribute("usuarioActual");

        if (usuarioActual == null) {
            return "redirect:/login";
        }

        Usuario usuarioActualizado = usuarioService.buscarPorId(usuarioActual.getId_usuario());

        if (usuarioActualizado == null) {
            session.invalidate();
            return "redirect:/login";
        }

        if (!usuarioActualizado.getEstado()) {
            session.invalidate();
            if (redirectAttributes != null) {
                redirectAttributes.addFlashAttribute("error",
                        "Tu cuenta ha sido desactivada. Contacta al administrador.");
            }
            return "redirect:/login";
        }

        if (!rolEsperado.equals(usuarioActualizado.getCargo())) {
            session.invalidate();
            if (redirectAttributes != null) {
                redirectAttributes.addFlashAttribute("error",
                        "Tu rol ha cambiado. Por favor, inicia sesión nuevamente.");
            }
            return "redirect:/login";
        }

        session.setAttribute("usuarioActual", usuarioActualizado);

        return null;
    }

    public String validarVendedor(HttpSession session, RedirectAttributes redirectAttributes) {
        return validarAcceso(session, "Vendedor", redirectAttributes);
    }

    public String validarAdmin(HttpSession session, RedirectAttributes redirectAttributes) {
        return validarAcceso(session, "Administrador", redirectAttributes);
    }
}
