<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Crear Producto - Catálogo</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>
  <div class="container my-5 gestion-form-container">
    <h2 class="text-center mb-4">Agregar Nuevo Producto</h2>
    <form action="${pageContext.request.contextPath}/admin/producto-crear" method="post">
      <div class="mb-3">
        <label class="form-label">Nombre del producto</label>
        <input type="text" class="form-control" name="nombre" placeholder="Ejemplo: Pelota de fútbol" required>
      </div>
      <div class="mb-3">
        <label class="form-label">Descripción</label>
        <textarea class="form-control" name="descripcion" rows="3" placeholder="Ejemplo: Balón profesional de cuero sintético" required></textarea>
      </div>
      <div class="mb-3">
        <label class="form-label">Precio (S/)</label>
        <input type="number" class="form-control" name="precio" placeholder="0.00" min="0" step="0.01" required>
      </div>
      <div class="mb-3">
        <label class="form-label">Stock</label>
        <input type="number" class="form-control" name="stock" placeholder="Cantidad" min="0" required>
      </div>
      <div class="mb-3">
        <label class="form-label">Imagen (URL o ruta)</label>
        <input type="text" class="form-control" name="imagen" value="${producto.imagen}" placeholder="https://ejemplo.com/imagen.jpg">
      </div>
      <div class="mb-3">
        <label class="form-label">Categoría</label>
        <select class="form-select" name="idCategoria" required>
          <option value="">Selecciona una categoría</option>
          <c:forEach var="categoria" items="${categorias}">
            <option value="${categoria.idCategoria}">${categoria.nombre}</option>
          </c:forEach>
        </select>
      </div>
      <div class="mb-3">
        <label class="form-label">Estado</label>
        <select class="form-select" name="estado" required>
          <option value="true" selected>Activo</option>
          <option value="false">Inactivo</option>
        </select>
      </div>
      <div class="text-end">
        <button type="submit" class="btn btn-primary">Guardar</button>
        <a href="${pageContext.request.contextPath}/admin/gestion#productos" class="btn btn-secondary">Cancelar</a>
      </div>
    </form>
  </div>
</body>
</html>