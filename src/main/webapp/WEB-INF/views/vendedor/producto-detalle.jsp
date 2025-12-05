<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${producto.nombre} - Detalle</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>

  <!-- Contenido principal -->
  <div class="container my-5" style="margin-top: 150px;">
    <div class="card shadow-lg">
      <div class="row g-0 align-items-center">
        <!-- Imagen del producto -->
        <div class="col-md-5 p-4 d-flex align-items-center justify-content-center">
          <img src="${producto.imagen}" class="img-fluid rounded" alt="${producto.nombre}">
        </div>

        <!-- Información del producto -->
        <div class="col-md-7">
          <div class="card-body">
            <h1 class="h3 mb-2" style="color:#1976d2; font-weight:700;">${producto.nombre}</h1>
            <p class="text-muted mb-3"><span class="me-2">Código:</span> PROD${producto.idProducto}</p>

            <div class="mb-3">
              <span class="fw-semibold">Descripción:</span>
              <p class="mb-0">${producto.descripcion}</p>
            </div>

            <p class="fs-5 fw-bold text-success mb-4">Precio: S/ ${producto.precio}</p>

            <div class="d-flex flex-wrap gap-3">
              <form action="${pageContext.request.contextPath}/vendedor/carrito/agregar" method="POST">
                <input type="hidden" name="idProducto" value="${producto.idProducto}">
                <input type="hidden" name="cantidad" value="1">
                <button type="submit" class="btn btn-success">
                  <i class="bi bi-cart-plus"></i> Agregar al carrito
                </button>
              </form>
              <a href="${pageContext.request.contextPath}/vendedor/catalogo" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left"></i> Volver al catálogo
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <script src="${pageContext.request.contextPath}/assets/js/cart.js"></script>
</body>
</html>
