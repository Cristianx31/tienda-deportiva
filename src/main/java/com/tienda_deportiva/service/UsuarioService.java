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

    public List<Usuario> listarTodos() {
        return usuarioRepository.findAll();
    }

    public int crearUsuario(Usuario usuario) {
        return usuarioRepository.save(usuario);
    }

    public Usuario buscarPorId(Integer id) {
        return usuarioRepository.findById(id);
    }

    public void actualizar(Usuario usuario) {
        usuarioRepository.update(usuario);
    }

    public void eliminar(Integer id) {
        usuarioRepository.delete(id);
    }

    public Usuario buscarPorUsuarioYContrasena(String usuario, String contrasena) {
        Usuario u = usuarioRepository.findByUsuario(usuario);
        if (u != null && u.getContrasena().equals(contrasena)) {
            return u;
        }
        return null;
    }

    public boolean tieneVentasOAsistencias(Integer idUsuario) {
        return usuarioRepository.tieneVentasOAsistencias(idUsuario);
    }

    public Usuario buscarPorUsuario(String usuario) {
        return usuarioRepository.findByUsuario(usuario);
    }
}