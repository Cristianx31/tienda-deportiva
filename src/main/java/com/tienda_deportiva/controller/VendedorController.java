package com.tienda_deportiva.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/vendedor")
public class VendedorController {
    @GetMapping("/index")
    public String index() {
        return "vendedor/index";
    }

    @GetMapping("/perfil")
    public String perfilVendedor() {
        return "vendedor/perfil-vendedor";
    }

}
