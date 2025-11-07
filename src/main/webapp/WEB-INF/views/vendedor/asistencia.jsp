<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Marcar Asistencia - DeportesX</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
  <div class="container my-5">
    <div class="card shadow-lg mx-auto" style="max-width: 480px;">
      <div class="card-header text-center bg-dark text-white rounded-top">
        <h3 class="mb-0"><i class="bi bi-fingerprint me-2"></i>Registro de Asistencia</h3>
      </div>
      <div class="card-body text-center">
        <hr>
        <!-- Fecha y Hora -->
        <div class="mb-2">
          <span class="fw-bold"><i class="bi bi-calendar-event me-1"></i>Lunes, 15 de Noviembre de 2023</span>
        </div>
        <div class="mb-3">
          <span class="fs-5 text-primary"><i class="bi bi-clock-history me-1"></i>08:15:32 AM</span>
        </div>
        <!-- Botones -->
        <div class="d-flex justify-content-center gap-2 mb-3">
          <button class="btn btn-success">
            <i class="bi bi-box-arrow-in-right me-1"></i>Ingreso
          </button>
          <button class="btn btn-secondary" disabled>
            <i class="bi bi-box-arrow-right me-1"></i>Salida
          </button>
        </div>
        <!-- Estado -->
        <div class="alert alert-warning text-center py-2 mb-3">
          <i class="bi bi-info-circle me-1"></i><strong>Estado:</strong> Esperando registro de ingreso
        </div>
        <!-- Historial -->
        <h5 class="mb-2"><i class="bi bi-clock-history me-2"></i>Registros de Hoy</h5>
        <div class="d-flex justify-content-between align-items-center mb-2 px-2 py-1 border rounded">
          <div>
            <i class="bi bi-box-arrow-in-right text-success me-2"></i>
            <span>Ingreso:</span>
          </div>
          <div>
            <span class="me-2">--:--:--</span>
            <span class="badge bg-secondary">Pendiente</span>
          </div>
        </div>
        <div class="d-flex justify-content-between align-items-center mb-2 px-2 py-1 border rounded">
          <div>
            <i class="bi bi-box-arrow-right text-danger me-2"></i>
            <span>Salida:</span>
          </div>
          <div>
            <span class="me-2">--:--:--</span>
            <span class="badge bg-secondary">Pendiente</span>
          </div>
        </div>
        <!-- Navegación -->
        <div class="d-flex justify-content-between mt-4">
          <a href="${pageContext.request.contextPath}/vendedor/perfil" class="btn btn-outline-secondary btn-sm">
            <i class="bi bi-arrow-left me-1"></i>Volver
          </a>
          <a href="${pageContext.request.contextPath}/vendedor/catalogo" class="btn btn-primary btn-sm">
            Continuar <i class="bi bi-arrow-right ms-1"></i>
          </a>
        </div>
      </div>
    </div>
  </div>
</body>
</html>