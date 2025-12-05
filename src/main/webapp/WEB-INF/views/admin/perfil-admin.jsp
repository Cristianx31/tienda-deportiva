<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Perfil Administrador - DeportesX</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>
  <div class="container my-5">
    <div class="d-flex justify-content-start mb-3">
      <a href="${pageContext.request.contextPath}/admin/gestion" class="btn btn-outline-secondary btn-sm">
        <i class="bi bi-arrow-left"></i> Volver
      </a>
    </div>
    <div class="card shadow-lg mx-auto" style="max-width: 420px;">
      <div class="card-header text-center bg-dark text-white rounded-top">
        <h3><i class="bi bi-person-badge"></i> Perfil Administrador</h3>
      </div>
      <div class="card-body text-center">
        <!-- Icono de usuario grande y centrado -->
        <div class="d-flex justify-content-center mb-3">
          <span class="bg-light rounded-circle shadow" style="width:100px; height:100px; display:flex; align-items:center; justify-content:center;">
            <i class="bi bi-person-circle" style="font-size:60px; color:#1976d2;"></i>
          </span>
        </div>
        <!-- Nombre y badge centrados -->
        <h5 class="mb-1 fw-bold text-primary">${usuario.nombre_completo}</h5>
        <span class="badge bg-danger mb-3 mx-auto" style="display:inline-block;">${usuario.cargo}</span>
        <hr>
        <!-- Datos personales -->
        <div class="text-start mb-2">
          <i class="bi bi-envelope"></i>
          <span class="ms-1 fw-bold">Correo:</span>
          <span>${usuario.correo}</span>
        </div>
        <div class="text-start mb-2">
          <i class="bi bi-person-badge"></i>
          <span class="ms-1 fw-bold">Usuario:</span>
          <span>${usuario.usuario}</span>
        </div>
        <div class="text-start mb-2">
          <i class="bi bi-shield-lock"></i>
          <span class="ms-1 fw-bold">Nivel de acceso:</span>
          <span>
            <c:choose>
              <c:when test="${usuario.cargo == 'Administrador'}">Administrador General</c:when>
              <c:otherwise>Vendedor</c:otherwise>
            </c:choose>
          </span>
        </div>
        <hr>
        <!-- Botón cerrar sesión -->
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger w-100">
          Cerrar Sesión
        </a>
      </div>
    </div>
  </div>
</body>
</html>