<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Métricas - DeportesX</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="../assets/css/style.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>
  <div class="container my-5">
    <div class="d-flex justify-content-start mb-3">
      <a href="gestion.html" class="btn btn-outline-secondary btn-sm">
        <i class="bi bi-arrow-left"></i> Volver
      </a>
    </div>
    <div class="metricas-header mb-4">
      <i class="bi bi-bar-chart-line-fill"></i>
      <h2 class="text-center fw-bold text-primary">Métricas de la Tienda Deportiva</h2>
    </div>
    <div class="dashboard-grid-metricas">
      <!-- Ventas Mensuales -->
      <div class="col-lg-6 col-md-6 d-flex">
        <div class="card-metric text-center p-4 flex-fill">
          <h5 class="card-title mb-4">Ventas Mensuales</h5>
          <div class="mb-3">
            <div class="text-start mb-2">Enero</div>
            <div class="progress mb-2" style="height: 22px;">
              <div class="progress-bar bg-success" style="width: 60%">S/ 9,000</div>
            </div>
            <div class="text-start mb-2">Febrero</div>
            <div class="progress mb-2" style="height: 22px;">
              <div class="progress-bar bg-success" style="width: 70%">S/ 10,500</div>
            </div>
            <div class="text-start mb-2">Marzo</div>
            <div class="progress mb-2" style="height: 22px;">
              <div class="progress-bar bg-success" style="width: 73%">S/ 11,000</div>
            </div>
            <div class="text-start mb-2">Meta mensual</div>
            <div class="progress" style="height: 22px;">
              <div class="progress-bar bg-warning" style="width: 100%">S/ 15,000</div>
            </div>
          </div>
          <small class="text-muted d-block mt-3">Actualizado: Octubre 2025</small>
        </div>
      </div>
      <!-- Categoría Más Vendida -->
      <div class="col-lg-6 col-md-6 d-flex">
        <div class="card-metric text-center p-4 flex-fill">
          <h5 class="card-title mb-4">Categoría Más Vendida</h5>
          <div class="mb-3">
            <div class="text-start mb-2">Running</div>
            <div class="progress mb-2" style="height: 22px;">
              <div class="progress-bar bg-success" style="width: 40%">40%</div>
            </div>
            <div class="text-start mb-2">Tenis</div>
            <div class="progress mb-2" style="height: 22px;">
              <div class="progress-bar bg-info" style="width: 10%">10%</div>
            </div>
            <div class="text-start mb-2">Boxeo</div>
            <div class="progress mb-2" style="height: 22px;">
              <div class="progress-bar bg-danger" style="width: 20%">20%</div>
            </div>
            <div class="text-start mb-2">Fútbol</div>
            <div class="progress mb-2" style="height: 22px;">
              <div class="progress-bar bg-primary" style="width: 20%">20%</div>
            </div>
            <div class="text-start mb-2">Otros</div>
            <div class="progress" style="height: 22px;">
              <div class="progress-bar bg-secondary" style="width: 10%">10%</div>
            </div>
          </div>
          <small class="text-muted d-block mt-3">Comparado con otras categorías</small>
        </div>
      </div>
      <!-- Asistencia de Empleados -->
      <div class="col-lg-6 col-md-6 d-flex">
        <div class="card-metric text-center p-4 flex-fill">
          <h5 class="card-title mb-4">Asistencia de Empleados</h5>
          <div class="mb-3">
            <div class="text-start mb-2">Mes anterior</div>
            <div class="progress mb-2" style="height: 22px;">
              <div class="progress-bar bg-warning" style="width: 88%">88% asistencia</div>
            </div>
            <div class="text-start mb-2">Este mes</div>
            <div class="progress mb-2" style="height: 22px;">
              <div class="progress-bar bg-success" style="width: 92%">92% asistencia</div>
            </div>
            <div class="mt-3 mb-2 fw-bold text-success">Promedio horas trabajadas: 7.8h</div>
            <div class="alert alert-danger py-2 mb-2" style="font-size: 0.95rem;">
              <strong>Baja asistencia:</strong> J. Pérez, M. Díaz
            </div>
          </div>
          <small class="text-muted d-block">Octubre 2025</small>
        </div>
      </div>
      <!-- Inventario Crítico -->
      <div class="col-lg-6 col-md-6 d-flex">
        <div class="card-metric p-4 flex-fill">
          <h5 class="card-title mb-4 text-danger">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>Inventario Crítico
          </h5>
          <ul class="list-group mb-3">
            <li class="list-group-item d-flex justify-content-between align-items-center">
              Guantes de Boxeo <span class="badge bg-danger rounded-pill">2</span>
            </li>
            <li class="list-group-item d-flex justify-content-between align-items-center">
              Zapatillas Running <span class="badge bg-warning rounded-pill">4</span>
            </li>
            <li class="list-group-item d-flex justify-content-between align-items-center">
              Pelotas de Tenis <span class="badge bg-danger rounded-pill">1</span>
            </li>
          </ul>
          <div class="mb-2">
          </div>
          <small class="text-muted">Productos con stock menor a 5 unidades</small>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
