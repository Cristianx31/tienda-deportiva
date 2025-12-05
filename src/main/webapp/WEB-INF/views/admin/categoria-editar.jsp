<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Editar Categoría</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>
  <div class="container my-5 gestion-form-container">
    <h2 class="text-center mb-4"><i class="bi bi-tags"></i> Editar Categoría</h2>
    <form action="${pageContext.request.contextPath}/admin/categoria-editar" method="post">
      <input type="hidden" name="idCategoria" value="${categoria.idCategoria}" />
      <div class="mb-3">
        <label class="form-label">Nombre de la categoría</label>
        <input type="text" class="form-control" name="nombre" value="${categoria.nombre}" required>
      </div>
      <div class="mb-3">
        <label class="form-label">Estado</label>
        <select class="form-select" name="estado" required>
          <option value="true" ${categoria.estado ? 'selected' : ''}>Activa</option>
          <option value="false" ${!categoria.estado ? 'selected' : ''}>Inactiva</option>
        </select>
      </div>
      <div class="text-end">
        <button type="submit" class="btn btn-primary">Guardar Cambios</button>
        <a href="${pageContext.request.contextPath}/admin/gestion#categorias" class="btn btn-secondary">Cancelar</a>
      </div>
    </form>
  </div>
</body>
</html>