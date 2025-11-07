package com.tienda_deportiva.controller;

import com.tienda_deportiva.model.Empleado;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.Model;

@Controller
public class LoginController {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping("/login")
    public String mostrarLogin() {
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String usuario, @RequestParam String contrasena, Model model) {
        String sql = "SELECT * FROM usuario WHERE usuario = ? AND contrasena = ?";
        Empleado empleado = jdbcTemplate.query(sql, rs -> {
            if (rs.next()) {
                Empleado e = new Empleado();
                e.setId(rs.getLong("id_usuario"));
                e.setDni(rs.getString("dni"));
                e.setNombreCompleto(rs.getString("nombre_completo"));
                e.setCargo(rs.getString("cargo"));
                e.setCorreo(rs.getString("correo"));
                e.setUsuario(rs.getString("usuario"));
                e.setContrasena(rs.getString("contrasena"));
                e.setEstado(rs.getBoolean("estado"));
                return e;
            }
            return null;
        }, usuario, contrasena);

        if (empleado != null) {
            if (Boolean.TRUE.equals(empleado.getEstado())) {
                if ("Administrador".equalsIgnoreCase(empleado.getCargo())) {
                    return "redirect:/admin/gestion";
                } else if ("Vendedor".equalsIgnoreCase(empleado.getCargo())) {
                    return "redirect:/vendedor/index";
                } else {
                    model.addAttribute("error", "Cargo no reconocido.");
                    return "login";
                }
            } else {
                model.addAttribute("error", "Cuenta inactiva, contacte al administrador.");
                return "login";
            }
        } else {
            model.addAttribute("error", "Usuario o contraseña incorrectos.");
            return "login";
        }
    }
}