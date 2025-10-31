<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Detalle de Venta - DeportesX</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="../assets/css/style.css">
</head>
<body>
  <div class="container my-5">
    <div class="card shadow-lg mx-auto" style="max-width: 600px;">
      <div class="card-header bg-primary text-white text-center">
        <h4><i class="bi bi-receipt"></i> Detalle de Venta</h4>
      </div>
      <div class="card-body">
        <!-- Datos principales de la venta -->
        <div class="mb-3">
          <span class="fw-bold">ID Venta:</span> 001<br>
          <span class="fw-bold">Fecha:</span> 2025-09-10<br>
          <span class="fw-bold">Estado:</span> <span class="badge bg-success">Pagado</span>
        </div>
        <hr>
        <!-- Datos del cliente -->
        <div class="mb-3">
          <span class="fw-bold">Cliente:</span> Sthefany Solis<br>
          <span class="fw-bold">DNI:</span> 75757575
        </div>
        <hr>
        <!-- Productos vendidos -->
        <h5 class="mb-3 text-primary"><i class="bi bi-box-seam"></i> Productos</h5>
        <table class="table table-bordered align-middle">
          <thead>
            <tr>
              <th>Producto</th>
              <th>Cantidad</th>
              <th>Precio Unitario</th>
              <th>Subtotal</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>Guantes de Boxeo</td>
              <td>1</td>
              <td>S/ 150.00</td>
              <td>S/ 150.00</td>
            </tr>
            <tr>
              <td>Pelota de Fútbol</td>
              <td>2</td>
              <td>S/ 120.00</td>
              <td>S/ 240.00</td>
            </tr>
          </tbody>
        </table>
        <div class="text-end fs-5 fw-bold">
          Total: <span class="text-primary">S/ 390.00</span>
        </div>
      </div>
      <div class="card-footer text-center bg-light">
        <a href="ventas-empleado.html" class="btn btn-outline-secondary">
          <i class="bi bi-clock-history"></i> Historial
        </a>
        <a href="catalogo.html" class="btn btn-outline-success ms-2">
          <i class="bi bi-plus-circle"></i> Nueva Venta
        </a>
      </div>
    </div>
  </div>
</body>
</html>