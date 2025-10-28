package com.tienda_deportiva.controller;

import com.tienda_deportiva.model.Usuario;
import com.tienda_deportiva.repository.UsuarioRepository;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.Model;

@Controller
public class LoginController {

    private final UsuarioRepository usuarioRepository;

    public LoginController(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    @GetMapping("/login")
    public String mostrarLogin() {
        return "login";
    }

    @PostMapping("/login")
    public String autenticar(@RequestParam String usuario, @RequestParam String contrasena, Model model) {
        Usuario u = usuarioRepository.buscarPorUsuarioYContrasena(usuario, contrasena);

        if (u != null) {
            if ("Administrador".equalsIgnoreCase(u.getCargo())) {
                return "redirect:/admin/gestion";
            } else if ("Vendedor".equalsIgnoreCase(u.getCargo())) {
                return "redirect:/vendedor/index";
            } else {
                model.addAttribute("error", "Rol no permitido");
                return "login";
            }
        } else {
            model.addAttribute("error", "Usuario o contraseña incorrectos");
            return "login";
        }
    }
}