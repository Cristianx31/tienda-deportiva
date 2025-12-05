<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    <div class="card shadow-lg mx-auto" style="max-width: 600px;">
      <div class="card-header text-center bg-dark text-white rounded-top">
        <h3 class="mb-0"><i class="bi bi-fingerprint me-2"></i>Registro de Asistencia</h3>
      </div>
      <div class="card-body">
        <!-- Alertas -->
        <c:if test="${not empty success}">
          <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle me-2"></i>${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
          </div>
        </c:if>
        <c:if test="${not empty error}">
          <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-circle me-2"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
          </div>
        </c:if>
        <c:if test="${not empty warning}">
          <div class="alert alert-warning alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle me-2"></i>${warning}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
          </div>
        </c:if>

        <!-- Fecha y Hora actual -->
        <div class="text-center mb-3">
          <div class="mb-2">
            <span class="fw-bold fs-5"><i class="bi bi-calendar-event me-1"></i>
              <fmt:formatDate value="<%= new java.util.Date() %>" pattern="EEEE, dd 'de' MMMM 'de' yyyy" />
            </span>
          </div>
        </div>

        <!-- Botones de Registro -->
        <div class="d-flex justify-content-center gap-3 mb-4">
          <form method="post" action="${pageContext.request.contextPath}/vendedor/marcar-entrada">
            <button type="submit" class="btn btn-success btn-lg" 
                    ${asistenciaHoy != null ? 'disabled' : ''}>
              <i class="bi bi-box-arrow-in-right me-2"></i>Marcar Entrada
            </button>
          </form>
          <form method="post" action="${pageContext.request.contextPath}/vendedor/marcar-salida">
            <button type="submit" class="btn btn-danger btn-lg" 
                    ${asistenciaHoy == null || asistenciaHoy.horaSalida != null ? 'disabled' : ''}>
              <i class="bi bi-box-arrow-right me-2"></i>Marcar Salida
            </button>
          </form>
        </div>

        <!-- Estado del día -->
        <div class="text-center mb-4">
          <c:choose>
            <c:when test="${asistenciaHoy == null}">
              <div class="alert alert-warning py-2">
                <i class="bi bi-info-circle me-1"></i><strong>Estado:</strong> No has marcado entrada
              </div>
            </c:when>
            <c:when test="${asistenciaHoy.horaSalida == null}">
              <div class="alert alert-info py-2">
                <i class="bi bi-check-circle me-1"></i><strong>Estado:</strong> En turno (pendiente salida)
              </div>
            </c:when>
            <c:otherwise>
              <div class="alert alert-success py-2">
                <i class="bi bi-check-circle-fill me-1"></i><strong>Estado:</strong> Jornada completada
              </div>
            </c:otherwise>
          </c:choose>
        </div>

        <!-- Registro de Hoy -->
        <h5 class="mb-3 text-center"><i class="bi bi-calendar-check me-2"></i>Registro de Hoy</h5>
        <div class="row g-2 mb-4">
          <div class="col-6">
            <div class="card border-success">
              <div class="card-body text-center py-2">
                <div class="text-success mb-1">
                  <i class="bi bi-box-arrow-in-right fs-4"></i>
                </div>
                <small class="text-muted d-block">Entrada</small>
                <strong class="fs-5">
                  <c:choose>
                    <c:when test="${asistenciaHoy != null}">
                      <fmt:formatDate value="${asistenciaHoy.horaIngresoAsDate}" pattern="HH:mm:ss" type="time"/>
                    </c:when>
                    <c:otherwise>--:--:--</c:otherwise>
                  </c:choose>
                </strong>
              </div>
            </div>
          </div>
          <div class="col-6">
            <div class="card border-danger">
              <div class="card-body text-center py-2">
                <div class="text-danger mb-1">
                  <i class="bi bi-box-arrow-right fs-4"></i>
                </div>
                <small class="text-muted d-block">Salida</small>
                <strong class="fs-5">
                  <c:choose>
                    <c:when test="${asistenciaHoy != null && asistenciaHoy.horaSalida != null}">
                      <fmt:formatDate value="${asistenciaHoy.horaSalidaAsDate}" pattern="HH:mm:ss" type="time"/>
                    </c:when>
                    <c:otherwise>--:--:--</c:otherwise>
                  </c:choose>
                </strong>
              </div>
            </div>
          </div>
        </div>

        <!-- Botón Ver Historial -->
        <div class="text-center mb-3">
          <a href="${pageContext.request.contextPath}/vendedor/historial-asistencia" class="btn btn-primary">
            <i class="bi bi-calendar-range me-1"></i>Historial
          </a>
        </div>

        <!-- Navegación -->
        <div class="d-flex justify-content-between mt-4">
          <a href="${pageContext.request.contextPath}/vendedor/perfil" class="btn btn-outline-secondary">
            <i class="bi bi-arrow-left me-1"></i>Volver a Perfil
          </a>
          <a href="${pageContext.request.contextPath}/vendedor/catalogo" class="btn btn-primary">
            Ir a Catálogo <i class="bi bi-arrow-right ms-1"></i>
          </a>
        </div>
      </div>
    </div>
  </div>
</body>
</html>