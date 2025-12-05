<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Editar Asistencia - DeportesX</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>
  <div class="container my-5">
    <div class="card shadow-lg">
      <div class="card-header text-center">
        <h3><i class="bi bi-pencil"></i> Editar Asistencia</h3>
      </div>
      <form class="p-4" action="${pageContext.request.contextPath}/admin/asistencia-editar" method="post">
        <input type="hidden" name="idAsistencia" value="${asistencia.idAsistencia}" />
        <div class="mb-3">
          <label for="usuarioAsistencia" class="form-label">Usuario</label>
          <select class="form-select" id="usuarioAsistencia" name="idUsuario" required>
            <option value="">Selecciona un usuario</option>
            <c:forEach var="usuario" items="${usuarios}">
              <option value="${usuario.id_usuario}" ${usuario.id_usuario == asistencia.idUsuario ? 'selected' : ''}>${usuario.nombre_completo}</option>
            </c:forEach>
          </select>
        </div>
        <div class="mb-3">
          <label for="fechaAsistencia" class="form-label">Fecha</label>
          <input type="date" class="form-control" id="fechaAsistencia" name="fecha" value="${asistencia.fecha}" required>
        </div>
        <div class="mb-3">
          <label for="horaIngresoAsistencia" class="form-label">Hora Ingreso</label>
          <input type="time" class="form-control" id="horaIngresoAsistencia" name="horaIngreso" value="${asistencia.horaIngreso}" required>
        </div>
        <div class="mb-3">
          <label for="horaSalidaAsistencia" class="form-label">Hora Salida</label>
          <input type="time" class="form-control" id="horaSalidaAsistencia" name="horaSalida" value="${asistencia.horaSalida}">
        </div>
        <div class="d-flex justify-content-between">
          <a href="${pageContext.request.contextPath}/admin/gestion?tab=asistencia" class="btn btn-secondary">Cancelar</a>
          <button type="submit" class="btn btn-success">Guardar Cambios</button>
        </div>
      </form>
    </div>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
