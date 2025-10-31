<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Detalle del Producto - DeportesX</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="../assets/css/style.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>

  <!-- Navbar -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
      <a class="navbar-brand" href="index.html">DeportesX</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" 
              data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" 
              aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ms-auto">
          <li class="nav-item"><a class="nav-link" href="catalogo.html">Catálogo</a></li>
          <li class="nav-item"><a class="nav-link" href="gestion.html">Gestión</a></li>
        </ul>
      </div>
    </div>
  </nav>

  <!-- Contenido principal -->
  <div class="container my-5">
    <div class="card shadow-lg">
      <div class="row g-0">
        <!-- Imagen del producto -->
        <div class="col-md-5 d-flex align-items-center justify-content-center">
          <img src="../assets/img/pelota-futbol.jpg" class="img-fluid rounded-start" alt="Pelota de Fútbol" style="max-width: 80%; height: auto;">
        </div>

        <!-- Información del producto -->
        <div class="col-md-7">
          <div class="card-body">
            <h3 class="card-title">Pelota de Fútbol</h3>
            <p class="text-muted">Código: PROD001</p>
            <p><strong>Descripción:</strong> Balón profesional certificado por FIFA Quality Pro, ideal para partidos oficiales y entrenamientos de alto rendimiento.</p>
            <p><strong>Stock disponible:</strong> 8 unidades</p>
            <p class="fs-5 fw-bold text-success">Precio: S/ 120.00</p>

            <div class="d-flex gap-3">
              <a href="venta.html" class="btn btn-success">
                <i class="bi bi-cart-plus"></i> Agregar al carrito
              </a>
              <a href="catalogo.html" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left"></i> Volver al catálogo
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
