<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Historial de Asistencia - DeportesX</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
  <div class="container my-5">
    <div class="card shadow-lg">
      <div class="card-header bg-dark text-white">
        <div class="d-flex justify-content-between align-items-center">
          <h3 class="mb-0"><i class="bi bi-clock-history me-2"></i>Historial de Asistencia</h3>
        </div>
      </div>
      <div class="card-body">
        <!-- Info del Usuario -->
        <div class="mb-4 p-3 bg-light rounded">
          <i class="bi bi-person-circle me-2"></i>
          <strong>${usuario.nombre_completo}</strong> - ${usuario.cargo}
        </div>

        <!-- Tabla Completa -->
        <div class="table-responsive">
          <table class="table table-striped table-hover">
            <thead class="table-dark">
              <tr>
                <th>#</th>
                <th>Fecha</th>
                <th>Día</th>
                <th>Hora Entrada</th>
                <th>Hora Salida</th>
                <th>Estado</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${asistencias}" var="asist" varStatus="status">
                <tr>
                  <td>${status.count}</td>
                  <td>
                    <fmt:formatDate value="${asist.fechaAsDate}" pattern="dd/MM/yyyy" type="date"/>
                  </td>
                  <td>
                    <fmt:formatDate value="${asist.fechaAsDate}" pattern="EEEE" type="date"/>
                  </td>
                  <td>
                    <span class="badge bg-success">
                      <i class="bi bi-box-arrow-in-right me-1"></i>
                      <fmt:formatDate value="${asist.horaIngresoAsDate}" pattern="HH:mm:ss" type="time"/>
                    </span>
                  </td>
                  <td>
                    <c:choose>
                      <c:when test="${asist.horaSalida != null}">
                        <span class="badge bg-danger">
                          <i class="bi bi-box-arrow-right me-1"></i>
                          <fmt:formatDate value="${asist.horaSalidaAsDate}" pattern="HH:mm:ss" type="time"/>
                        </span>
                      </c:when>
                      <c:otherwise>
                        <span class="badge bg-secondary">
                          <i class="bi bi-clock me-1"></i>Pendiente
                        </span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td>
                    <c:choose>
                      <c:when test="${asist.horaSalida != null}">
                        <span class="badge bg-success">Completo</span>
                      </c:when>
                      <c:otherwise>
                        <span class="badge bg-warning">En turno</span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                </tr>
              </c:forEach>
              <c:if test="${empty asistencias}">
                <tr>
                  <td colspan="6" class="text-center text-muted py-4">
                    <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                    No hay registros de asistencia
                  </td>
                </tr>
              </c:if>
            </tbody>
          </table>
        </div>

        <!-- Botón de navegación -->
        <div class="mt-4">
          <a href="${pageContext.request.contextPath}/vendedor/asistencia" class="btn btn-secondary">
            <i class="bi bi-arrow-left me-1"></i>Volver a Asistencia
          </a>
        </div>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
