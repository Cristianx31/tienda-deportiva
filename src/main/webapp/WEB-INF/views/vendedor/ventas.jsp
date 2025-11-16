<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Mis Ventas - DeportesX</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
  <!-- NAVBAR -->
  <nav class="navbar navbar-dark bg-dark fixed-top">
    <div class="container">
      <a class="navbar-brand" href="${pageContext.request.contextPath}/vendedor/index">
        <span style="color:#1976d2;font-weight:900;">X</span>
        <span style="color:#fff;">DEPORTES x</span>
      </a>
      <div class="d-flex align-items-center gap-3">
        <a href="${pageContext.request.contextPath}/vendedor/index" class="btn btn-outline-light btn-sm">
          <i class="bi bi-house"></i> Inicio
        </a>
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm">
          <i class="bi bi-box-arrow-right"></i> Cerrar Sesión
        </a>
      </div>
    </div>
  </nav>

  <div class="container my-5" style="margin-top: 110px;">
    <div class="card shadow-lg">
      <div class="card-header bg-primary text-white">
        <h3><i class="bi bi-cash-coin"></i> Historial de Ventas</h3>
      </div>
      <div class="card-body">
        <c:if test="${empty ventas}">
          <div class="alert alert-info" role="alert">
            <i class="bi bi-info-circle"></i> No hay ventas registradas.
          </div>
        </c:if>
        
        <c:if test="${not empty ventas}">
          <table class="table table-hover text-center align-middle">
            <thead class="table-light">
              <tr>
                <th>ID Venta</th>
                <th>Cliente</th>
                <th>Fecha</th>
                <th>Total</th>
                <th>Estado</th>
                <th>Acciones</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="venta" items="${ventas}">
                <tr>
                  <td><strong>${venta.idVenta}</strong></td>
                  <td>${venta.nombreCliente}</td>
                  <td>${venta.fecha}</td>
                  <td><strong>S/ ${venta.total}</strong></td>
                  <td>
                    <c:choose>
                      <c:when test="${venta.estado == 'Pagado'}">
                        <span class="badge bg-success">Pagado</span>
                      </c:when>
                      <c:when test="${venta.estado == 'Pendiente'}">
                        <span class="badge bg-warning">Pendiente</span>
                      </c:when>
                      <c:otherwise>
                        <span class="badge bg-danger">Anulado</span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td>
                    <a href="${pageContext.request.contextPath}/vendedor/venta-detalle/${venta.idVenta}" class="btn btn-sm btn-outline-primary">
                      <i class="bi bi-eye"></i> Ver
                    </a>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </c:if>

        <div class="mt-3">
          <a href="${pageContext.request.contextPath}/vendedor/venta" class="btn btn-success">
            <i class="bi bi-plus-circle"></i> Nueva Venta
          </a>
          <a href="${pageContext.request.contextPath}/vendedor/index" class="btn btn-secondary">
            <i class="bi bi-arrow-left"></i> Volver
          </a>
        </div>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
