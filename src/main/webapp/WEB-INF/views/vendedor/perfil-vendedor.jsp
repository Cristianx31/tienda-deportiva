<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Perfil - DeportesX</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>
  <div class="container my-5">
    <div class="d-flex justify-content-start mb-3">
      <a href="${pageContext.request.contextPath}/vendedor/index" class="btn btn-outline-secondary btn-sm">
        <i class="bi bi-arrow-left"></i> Volver
      </a>
    </div>
    <div class="card shadow-lg mx-auto" style="max-width: 420px;">
      <div class="card-header text-center bg-dark text-white rounded-top">
          <h3><i class="bi bi-person"></i> Mi Perfil</h3>
      </div>
      <div class="card-body text-center">
          <!-- Icono de usuario grande y centrado -->
          <div class="d-flex justify-content-center mb-3">
            <span class="bg-light rounded-circle shadow" style="width:100px; height:100px; display:flex; align-items:center; justify-content:center;">
              <i class="bi bi-person-circle" style="font-size:60px; color:#1976d2;"></i>
            </span>
          </div>
          <!-- Nombre y badge con información del usuario actual -->
          <h5 class="mb-1 fw-bold text-primary">${usuarioActual.nombre_completo}</h5>
          <span class="badge bg-primary mb-3 mx-auto" style="display:inline-block;">
            ${usuarioActual.cargo != null ? usuarioActual.cargo : 'Usuario'}
          </span>
          <hr>
          <!-- Datos personales -->
          <div class="text-start mb-2">
              <i class="bi bi-card-list"></i>
              <span class="ms-1 fw-bold">DNI:</span>
              <span>${usuarioActual.dni}</span>
          </div>
          <div class="text-start mb-2">
              <i class="bi bi-envelope"></i>
              <span class="ms-1 fw-bold">Correo:</span>
              <span>${usuarioActual.correo}</span>
          </div>
          <div class="text-start mb-2">
              <i class="bi bi-person-badge"></i>
              <span class="ms-1 fw-bold">Usuario:</span>
              <span>${usuarioActual.usuario}</span>
          </div>
          <div class="text-start mb-2">
              <i class="bi bi-clock"></i>
              <span class="ms-1 fw-bold">Horario:</span>
              <span>${usuarioActual.hora_entrada} - ${usuarioActual.hora_salida}</span>
          </div>
          <hr>
          <!-- Acciones -->
          <div class="d-grid gap-2">
              <a href="${pageContext.request.contextPath}/vendedor/asistencia" class="btn btn-warning">
                  Asistencia
              </a>
              <a href="${pageContext.request.contextPath}/vendedor/ventas-empleado" class="btn btn-primary">
                  Mis Ventas
              </a>
              <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-danger">
                  Cerrar Sesión
              </a>
          </div>
      </div>
    </div>
  </div>
</body>
</html>