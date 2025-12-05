<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Página de Publicidad</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
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
          <a class="nav-link active" href="${pageContext.request.contextPath}/vendedor/publicidad">Publicidad</a>
        </li>
        <li class="nav-item mx-2">
          <a class="nav-link" href="${pageContext.request.contextPath}/vendedor/catalogo">Catálogo</a>
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

  <div class="container my-5" style="margin-top: 150px;">
    <div class="banner">
      <div class="overlay"></div>
      <div class="banner-content text-center">
        <h1>🔥 GRAN OFERTA DEPORTIVA 🔥</h1>
        <p>Hasta 50% de descuento en zapatillas, ropa y accesorios</p>
        <a href="${pageContext.request.contextPath}/vendedor/catalogo" class="btn btn-banner btn-primary mb-4">Ver catálogo</a>
      </div>
    </div>
  </div>

  <!-- Publicidad adicional -->
  <div class="container my-5">
    <div class="row g-4">
      <div class="col-md-4">
        <div class="card h-100 shadow">
          <img src="../assets/img/zapatillas-publi.jpg" class="card-img-top" alt="Oferta Zapatillas">
          <div class="card-body">
            <h5 class="card-title">Zapatillas deportivas</h5>
            <p class="card-text">Descuentos exclusivos en marcas top. ¡Solo por esta semana!</p>
            <a href="catalogo.html" class="btn btn-outline-primary btn-sm">Ver oferta</a>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card h-100 shadow">
          <img src="../assets/img/ropad-publi.jpg" class="card-img-top" alt="Oferta Ropa">
          <div class="card-body">
            <h5 class="card-title">Ropa deportiva</h5>
            <p class="card-text">Hasta 40% en camisetas, shorts y más. ¡Renueva tu outfit!</p>
            <a href="catalogo.html" class="btn btn-outline-primary btn-sm">Ver oferta</a>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card h-100 shadow">
          <img src="../assets/img/acces-publi.jpg" class="card-img-top" alt="Oferta Accesorios">
          <div class="card-body">
            <h5 class="card-title">Accesorios</h5>
            <p class="card-text">Guantes, mochilas y más con hasta 30% de descuento.</p>
            <a href="catalogo.html" class="btn btn-outline-primary btn-sm">Ver oferta</a>
          </div>
        </div>
      </div>
    </div>
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
</body>
</html>