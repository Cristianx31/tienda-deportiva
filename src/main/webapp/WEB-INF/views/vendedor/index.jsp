<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Tienda Deportiva - Inicio</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
  <!-- NAVBAR PRINCIPAL -->
  <nav class="navbar navbar-dark bg-dark fixed-top">
    <div class="container">
      <a class="navbar-brand" href="${pageContext.request.contextPath}/vendedor/index">
        <span style="color:#1976d2;font-weight:900;">X</span>
        <span style="color:#fff;">DEPORTES x</span>
      </a>
      <ul class="navbar-nav flex-row ms-auto align-items-center">
        <li class="nav-item mx-2">
          <a class="nav-link active" href="${pageContext.request.contextPath}/vendedor/index">Inicio</a>
        </li>
        <li class="nav-item mx-2">
          <a class="nav-link" href="${pageContext.request.contextPath}/vendedor/publicidad">Publicidad</a>
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

  <!-- CONTENIDO PRINCIPAL -->
  <main class="main-home container my-5 p-5 rounded text-center" style="margin-top: 150px;">
    <h1>¡Bienvenido a <strong>DEPORTES X</strong>!</h1>
    <p class="lead">Aquí encontrarás los mejores artículos deportivos para todas las disciplinas.</p>
    
    <img src="${pageContext.request.contextPath}/assets/img/deporte-portada.jpg" alt="Artículos deportivos" class="img-fluid mt-3">
  </main>

  <div class="container mt-5">
    <h2 class="text-center mb-4">Categorías destacadas</h2>
    <div class="row">
      <!-- Fútbol -->
      <div class="col-md-4 mb-4">
        <div class="card h-100 shadow">
          <img src="${pageContext.request.contextPath}/assets/img/fut.jpg" class="card-img-top" alt="Fútbol">
          <div class="card-body">
            <h5 class="card-title">Fútbol</h5>
            <p class="card-text">Balones, camisetas, calzado y más.</p>
            <a href="${pageContext.request.contextPath}/vendedor/catalogo" class="btn btn-primary">Ver más</a>
          </div>
        </div>
      </div>
      <!-- Gimnasio -->
      <div class="col-md-4 mb-4">
        <div class="card h-100 shadow">
          <img src="${pageContext.request.contextPath}/assets/img/gim.jpg" class="card-img-top" alt="Gimnasio">
          <div class="card-body">
            <h5 class="card-title">Gimnasio</h5>
            <p class="card-text">Pesas, ropa deportiva, accesorios fitness.</p>
            <a href="${pageContext.request.contextPath}/vendedor/catalogo" class="btn btn-primary">Ver más</a>
          </div>
        </div>
      </div>
      <!-- Natación -->
      <div class="col-md-4 mb-4">
        <div class="card h-100 shadow">
          <img src="${pageContext.request.contextPath}/assets/img/nata.jpg" class="card-img-top" alt="Natación">
          <div class="card-body">
            <h5 class="card-title">Natación</h5>
            <p class="card-text">Gafas, trajes de baño, gorros y más.</p>
            <a href="${pageContext.request.contextPath}/vendedor/catalogo" class="btn btn-primary">Ver más</a>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- SUSCRIPCIÓN -->
  <div class="container mt-5">
    <h3 class="text-center">Suscríbete a nuestras novedades</h3>
    <form class="row justify-content-center mt-3">
      <div class="col-md-4">
        <input type="email" class="form-control" placeholder="Ingresa tu correo" required>
      </div>
      <div class="col-auto">
        <button type="submit" class="btn btn-primary">Suscribirme</button>
      </div>
    </form>
  </div>

  <!-- FOOTER -->
  <footer class="bg-dark text-white text-center py-4 mt-5">
    <p>&copy; 2025 Deportes X. Todos los derechos reservados.</p>
    <p>
      Síguenos en 
      <a href="#" class="text-white text-decoration-underline">Facebook</a> |
      <a href="#" class="text-white text-decoration-underline">Instagram</a>
    </p>
  </footer>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>