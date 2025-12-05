package com.tienda_deportiva.model;

public class Cliente {
    private Long idCliente;
    private String nombre;
    private String dni;

    public Cliente() {
    }

    public Cliente(Long idCliente, String nombre, String dni) {
        this.idCliente = idCliente;
        this.nombre = nombre;
        this.dni = dni;
    }

    public Long getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(Long idCliente) {
        this.idCliente = idCliente;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }
}
