package com.tienda_deportiva.controller;

import com.tienda_deportiva.model.Usuario;
import com.tienda_deportiva.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {

    @Autowired
    private UsuarioService usuarioService;

    @GetMapping("/login")
    public String mostrarLogin() {
        return "login";
    }

    @PostMapping("/login")
    public String procesarLogin(
            @RequestParam String usuario,
            @RequestParam String contrasena,
            HttpSession session,
            Model model) {

        Usuario usuarioEncontrado = usuarioService.buscarPorUsuario(usuario);

        if (usuarioEncontrado != null && usuarioEncontrado.getContrasena().equals(contrasena)) {
            if (!usuarioEncontrado.getEstado()) {
                model.addAttribute("error", "Usuario inactivo");
                return "login";
            }

            session.setAttribute("usuarioActual", usuarioEncontrado);
            
            if ("Administrador".equals(usuarioEncontrado.getCargo())) {
                return "redirect:/admin/gestion";
            } else {
                return "redirect:/vendedor/index";
            }
        } else {
            model.addAttribute("error", "Usuario o contraseña incorrectos");
            return "login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}