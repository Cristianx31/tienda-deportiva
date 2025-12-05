<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mis Ventas - DeportesX</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>
    <div class="container my-5">
    <div class="ventas-container-amplia">
    <h2 class="mb-4"><i class="bi bi-cash-coin"></i> Mi Historial de Ventas</h2>
    <div class="d-flex justify-content-start mb-4">
      <a href="${pageContext.request.contextPath}/vendedor/perfil" class="btn btn-outline-secondary btn-sm">
        <i class="bi bi-arrow-left"></i> Volver
      </a>
      <a href="${pageContext.request.contextPath}/vendedor/catalogo" class="btn btn-outline-success btn-sm ms-2 d-flex align-items-center justify-content-center">
        <i class="bi bi-shop me-2"></i> Ir al Catálogo
      </a>
    </div>
    <c:choose>
      <c:when test="${not empty ventas}">
        <table class="table table-hover text-center align-middle">
        <thead>
            <tr>
                <th>ID Venta</th>
                <th>Cliente</th>
                <th>Fecha</th>
                <th>Total</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="venta" items="${ventas}">
              <tr>
                  <td>${venta.idVenta}</td>
                  <td>${venta.nombreCliente}</td>
                  <td>${venta.fecha}</td>
                  <td>S/ ${venta.total}</td>
                  <td>
                      <a href="${pageContext.request.contextPath}/vendedor/venta-detalle/${venta.idVenta}" class="btn btn-outline-primary btn-sm">
                        <i class="bi bi-eye"></i> Ver
                      </a>
                  </td>
              </tr>
            </c:forEach>
        </tbody>
        </table>
      </c:when>
      <c:otherwise>
        <div class="alert alert-info">
          <i class="bi bi-info-circle"></i> No tienes ventas registradas aún.
        </div>
      </c:otherwise>
    </c:choose>
</div>
    </div>
</body>
</html>