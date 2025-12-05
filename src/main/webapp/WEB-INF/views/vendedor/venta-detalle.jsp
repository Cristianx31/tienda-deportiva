<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Detalle de Venta - DeportesX</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <style>
    .sale-card{max-width: 720px;}
  </style>
</head>
<body>
  <div class="container my-5">
    <div class="card shadow-lg mx-auto sale-card">
      <div class="card-header bg-primary text-white text-center">
        <h4><i class="bi bi-receipt"></i> Detalle de Venta</h4>
      </div>
      <div class="card-body">
        <c:choose>
          <c:when test="${not empty venta}">
            <!-- Datos desde la base de datos -->
            <div class="mb-3">
              <span class="fw-bold">ID Venta:</span> ${venta.idVenta}<br>
              <span class="fw-bold">Fecha:</span> ${venta.fecha}<br>
              <span class="fw-bold">Estado:</span> <span class="badge bg-success">Pagado</span>
            </div>
            <hr>
            <!-- Datos del cliente -->
            <div class="mb-3">
              <span class="fw-bold">Cliente:</span> ${venta.nombreCliente}<br>
              <span class="fw-bold">DNI:</span> ${venta.dniCliente}
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
                <c:forEach var="detalle" items="${detalles}">
                  <tr>
                    <td>${detalle.nombreProducto}</td>
                    <td>${detalle.cantidad}</td>
                    <td>S/ ${detalle.precioUnitario}</td>
                    <td>S/ ${detalle.subtotal}</td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
            <div class="text-end fs-5 fw-bold">
              Total: <span class="text-primary">S/ ${venta.total}</span>
            </div>
          </c:when>
          <c:otherwise>
            <!-- Datos desde sessionStorage (venta recién confirmada) -->
            <div id="js-content">
              <div class="mb-3">
                <span class="fw-bold">ID Venta:</span> <span id="sale-id">-</span><br>
                <span class="fw-bold">Fecha:</span> <span id="sale-date">-</span><br>
                <span class="fw-bold">Estado:</span> <span class="badge bg-success">Pagado</span>
              </div>
              <hr>
              <!-- Datos del cliente -->
              <div class="mb-3">
                <span class="fw-bold">Cliente:</span> <span id="client-name">-</span><br>
                <span class="fw-bold">DNI:</span> <span id="client-dni">-</span>
              </div>
              <hr>
              <!-- Productos vendidos -->
              <h5 class="mb-3 text-primary"><i class="bi bi-box-seam"></i> Productos</h5>
              <div id="empty-msg" class="d-none alert alert-warning">No hay una venta reciente para mostrar.</div>
              <table id="items-table" class="table table-bordered align-middle">
                <thead>
                  <tr>
                    <th>Producto</th>
                        <!-- Sin JavaScript en esta vista -->
                tbody.innerHTML = '';
                sale.items.forEach(function(i){
                  var tr = document.createElement('tr');
                  tr.innerHTML =
                    '<td>' + (i.name || '-') + '</td>' +
                    '<td>' + (i.qty || 1) + '</td>' +
                    '<td>S/ ' + Cart.formatCurrency(i.price || 0) + '</td>' +
                    '<td>S/ ' + Cart.formatCurrency((i.price || 0) * (i.qty || 1)) + '</td>';
                  tbody.appendChild(tr);
                });
                document.getElementById('sale-total').textContent = 'S/ ' + Cart.formatCurrency(sale.total || 0);
              })();
            </script>
          </c:otherwise>
        </c:choose>
      </div>
      <div class="card-footer text-center bg-light">
        <a href="${pageContext.request.contextPath}/vendedor/ventas-empleado" class="btn btn-outline-secondary">
          <i class="bi bi-clock-history"></i> Historial
        </a>
        <a href="${pageContext.request.contextPath}/vendedor/catalogo" class="btn btn-outline-success ms-2">
          <i class="bi bi-plus-circle"></i> Nueva Venta
        </a>
      </div>
    </div>
  </div>
</body>
</html>