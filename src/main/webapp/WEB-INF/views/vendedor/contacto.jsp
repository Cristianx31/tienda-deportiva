<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Contacto</title>
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
          <a class="nav-link" href="${pageContext.request.contextPath}/vendedor/publicidad">Publicidad</a>
        </li>
        <li class="nav-item mx-2">
          <a class="nav-link" href="${pageContext.request.contextPath}/vendedor/catalogo">Catálogo</a>
        </li>
        <li class="nav-item mx-2">
          <a class="nav-link active" href="${pageContext.request.contextPath}/vendedor/contacto">Contacto</a>
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
  <div class="container my-6" style="margin-top: 100px;">
    <h1 class="text-center mb-5">Contacto</h1>
    <div class="row justify-content-center">
      <!-- Información de contacto -->
      <div class="col-md-5 mb-4">
        <div class="card shadow-sm">
          <div class="card-body">
            <h2 class="text-primary mb-3">Nuestra Tienda</h2>
            <p><strong>📍 Dirección:</strong> Av. Principal 123, Huancayo, Perú</p>
            <p><strong>☎️ Teléfono:</strong> +51 987 654 321</p>
            <p><strong>📧 Correo:</strong> contacto@tiendadeportiva.com</p>
            <!-- Mapa eliminado por requerimiento: se quita iframe, scripts y componentes asociados -->
            <div class="alert alert-secondary mt-3" role="alert">
              <strong>Nota:</strong>  Nuestra dirección es Av. Principal 123, Huancayo, Perú.
            </div>
          </div>
        </div>
      </div>
      <!-- Formulario de contacto -->
      <div class="col-md-5 mb-4">
        <div class="card shadow-sm">
          <div class="card-body">
            <h2 class="text-primary mb-3">Envíanos un mensaje</h2>
            <form>
              <div class="mb-3">
                <label for="nombre" class="form-label">Nombre completo</label>
                <input type="text" class="form-control" id="nombre" placeholder="Escribe tu nombre">
              </div>
              <div class="mb-3">
                <label for="email" class="form-label">Correo electrónico</label>
                <input type="email" class="form-control" id="email" placeholder="ejemplo@email.com">
              </div>
              <div class="mb-3">
                <label for="telefono" class="form-label">Teléfono</label>
                <input type="tel" class="form-control" id="telefono" placeholder="+51 900 000 000">
              </div>
              <div class="mb-3">
                <label for="mensaje" class="form-label">Mensaje</label>
                <textarea class="form-control" id="mensaje" rows="4" placeholder="Escribe tu mensaje aquí..."></textarea>
              </div>
              <button type="submit" class="btn btn-primary w-100">Enviar</button>
            </form>
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