package com.tienda_deportiva.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin")
public class AsistenciaController {

    // Solo para VER historial en el admin (sin crear/editar/eliminar)
    // Las acciones se hacen desde el VendedorController
}
