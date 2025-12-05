<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Catálogo de Productos</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>

  <!-- Menú de navegación -->
  <nav class="navbar navbar-dark bg-dark fixed-top">
    <div class="container">
      <a class="navbar-brand" href="${pageContext.request.contextPath}/vendedor/index">
        <span style="color:#1976d2;font-weight:900;">X</span>
        <span style="color:#fff;">DEPORTES x</span>
      </a>
      <ul class="navbar-nav flex-row ms-auto align-items-center">
        <li class="nav-item mx-2">
          <a class="nav-link" href="${pageContext.request.contextPath}/vendedor/index">Inicio</a>
        </li>
        <li class="nav-item mx-2">
          <a class="nav-link" href="${pageContext.request.contextPath}/vendedor/publicidad">Publicidad</a>
        </li>
        <li class="nav-item mx-2">
          <a class="nav-link active" href="${pageContext.request.contextPath}/vendedor/catalogo">Catálogo</a>
        </li>
        <li class="nav-item mx-2">
          <a class="nav-link" href="${pageContext.request.contextPath}/vendedor/contacto">Contacto</a>
        </li>
        <li class="nav-item mx-2">
          <a class="nav-link" href="${pageContext.request.contextPath}/vendedor/venta"><span class="fw-semibold">Venta</span></a>
        </li>
        <li class="nav-item ms-2">
          <a class="nav-link" href="${pageContext.request.contextPath}/vendedor/perfil">
            <i class="bi bi-person-circle fs-5"></i> Mi cuenta
          </a>
        </li>
      </ul>
    </div>
  </nav>

  <!-- Contenido -->
  <div class="container my-6" style="margin-top: 100px;">
    <h2 class="text-center mb-4">Lista de productos</h2>

    <!-- Recorrer todas las categorías -->
    <c:forEach var="categoria" items="${categorias}">
      <c:if test="${categoria.estado}">
        <!-- Título de la categoría -->
        <h3 class="mt-5 mb-3">${categoria.nombre}</h3>
        <div class="row g-4">
          
          <!-- Filtrar productos de esta categoría -->
          <c:forEach var="producto" items="${productos}">
            <c:if test="${producto.idCategoria == categoria.idCategoria && producto.estado}">
              <div class="col-md-3">
                <div class="card h-100">
                  <img src="${producto.imagen}" class="card-img-top" alt="${producto.nombre}" style="height: 200px; object-fit: cover;">
                  <div class="card-body">
                    <h5 class="card-title">${producto.nombre}</h5>
                    <p class="card-text">${producto.descripcion}</p>
                    <p class="fw-bold">S/ ${producto.precio}</p>
                    <div class="d-flex justify-content-between">
                      <form action="${pageContext.request.contextPath}/vendedor/carrito/agregar" method="POST" style="display:inline;">
                        <input type="hidden" name="idProducto" value="${producto.idProducto}">
                        <input type="hidden" name="cantidad" value="1">
                        <button type="submit" class="btn btn-success btn-sm">Agregar a venta</button>
                      </form>
                      <a href="${pageContext.request.contextPath}/vendedor/producto-detalle/${producto.idProducto}" class="btn btn-outline-primary btn-sm">Ver detalles</a>
                    </div>
                  </div>
                </div>
              </div>
            </c:if>
          </c:forEach>
          
        </div>
      </c:if>
    </c:forEach>

  </div>
  
  <!-- footer -->
  <footer class="bg-dark text-white text-center py-4 mt-5">
    <p>&copy; 2025 Deportes X. Todos los derechos reservados.</p>
    <p>
      Síguenos en 
      <a href="#" class="text-white text-decoration-underline">Facebook</a> |
      <a href="#" class="text-white text-decoration-underline">Instagram</a>
    </p>
  </footer>
  
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/cart.js"></script>
    <script>
      (function(){
        document.querySelectorAll('.btn-add-cart').forEach(function(btn){
          btn.addEventListener('click', function(e){
            e.preventDefault();
            Cart.addItem({
              id: this.dataset.id,
              name: this.dataset.name,
              price: this.dataset.price,
              image: this.dataset.image,
              qty: 1
            });
            // Aviso simple
            this.textContent = 'Agregado ✓';
            setTimeout(()=> this.textContent = 'Agregar al carrito', 1200);
          });
        });
      })();
    </script>
</body>
</html>