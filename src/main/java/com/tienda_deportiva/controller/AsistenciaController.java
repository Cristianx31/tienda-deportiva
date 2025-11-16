package com.tienda_deportiva.controller;

import com.tienda_deportiva.service.AsistenciaService;
import com.tienda_deportiva.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin")
public class AsistenciaController {

    @Autowired
    private AsistenciaService asistenciaService;

    @Autowired
    private UsuarioService usuarioService;

    // Solo para VER historial en el admin (sin crear/editar/eliminar)
    // Las acciones se hacen desde el VendedorController
}
