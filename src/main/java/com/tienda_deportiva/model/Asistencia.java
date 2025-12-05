package com.tienda_deportiva.model;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.util.Date;

public class Asistencia {
    private int idAsistencia;
    private int idUsuario;
    private LocalDate fecha;
    private LocalTime horaIngreso;
    private LocalTime horaSalida;

    public Asistencia() {
    }

    public Asistencia(int idAsistencia, int idUsuario, LocalDate fecha, LocalTime horaIngreso, LocalTime horaSalida) {
        this.idAsistencia = idAsistencia;
        this.idUsuario = idUsuario;
        this.fecha = fecha;
        this.horaIngreso = horaIngreso;
        this.horaSalida = horaSalida;
    }

    public int getIdAsistencia() {
        return idAsistencia;
    }

    public void setIdAsistencia(int idAsistencia) {
        this.idAsistencia = idAsistencia;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public LocalDate getFecha() {
        return fecha;
    }

    public void setFecha(LocalDate fecha) {
        this.fecha = fecha;
    }

    public LocalTime getHoraIngreso() {
        return horaIngreso;
    }

    public void setHoraIngreso(LocalTime horaIngreso) {
        this.horaIngreso = horaIngreso;
    }

    public LocalTime getHoraSalida() {
        return horaSalida;
    }

    public void setHoraSalida(LocalTime horaSalida) {
        this.horaSalida = horaSalida;
    }

    public Date getFechaAsDate() {
        if (fecha == null)
            return null;
        return Date.from(fecha.atStartOfDay(ZoneId.systemDefault()).toInstant());
    }

    public Date getHoraIngresoAsDate() {
        if (horaIngreso == null || fecha == null)
            return null;
        return Date.from(fecha.atTime(horaIngreso).atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getHoraSalidaAsDate() {
        if (horaSalida == null || fecha == null)
            return null;
        return Date.from(fecha.atTime(horaSalida).atZone(ZoneId.systemDefault()).toInstant());
    }

    @Override
    public String toString() {
        return "Asistencia{" +
                "idAsistencia=" + idAsistencia +
                ", idUsuario=" + idUsuario +
                ", fecha=" + fecha +
                ", horaIngreso=" + horaIngreso +
                ", horaSalida=" + horaSalida +
                '}';
    }
}
