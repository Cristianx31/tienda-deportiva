<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Perfil Vendedor - DeportesX</title>
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
          <!-- Nombre y badge -->
          <h5 class="mb-1 fw-bold text-primary">Alonso Garcia</h5>
          <span class="badge bg-primary mb-3 mx-auto" style="display:inline-block;">Vendedor</span>
          <hr>
          <!-- Datos personales -->
          <div class="text-start mb-2">
              <i class="bi bi-card-list"></i>
              <span class="ms-1 fw-bold">DNI:</span>
              <span>87654321</span>
          </div>
          <div class="text-start mb-2">
              <i class="bi bi-envelope"></i>
              <span class="ms-1 fw-bold">Correo:</span>
              <span>alonso@correo.com</span>
          </div>
          <div class="text-start mb-2">
              <i class="bi bi-person-badge"></i>
              <span class="ms-1 fw-bold">Usuario:</span>
              <span>alonsog</span>
          </div>
          <div class="text-start mb-2">
              <i class="bi bi-clock"></i>
              <span class="ms-1 fw-bold">Horario:</span>
              <span>09:00 - 18:00</span>
          </div>
          <hr>
          <!-- Acciones -->
          <div class="d-grid gap-2">
              <a href="asistencia.html" class="btn btn-warning">
                  Asistencia
              </a>
              <a href="ventas-empleado.html" class="btn btn-primary">
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