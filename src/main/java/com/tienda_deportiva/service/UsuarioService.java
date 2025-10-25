package com.tienda_deportiva.service;

import com.tienda_deportiva.model.Usuario;
import com.tienda_deportiva.repository.UsuarioRepository;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class UsuarioService {

    private final UsuarioRepository usuarioRepository;

    public UsuarioService(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    public List<Usuario> listarUsuarios() {
        return usuarioRepository.findAll();
    }

    public int crearUsuario(Usuario usuario) {
        return usuarioRepository.save(usuario);
    }
}