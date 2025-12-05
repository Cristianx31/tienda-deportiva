<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Registrar Venta - DeportesX</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
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
          <a class="nav-link" href="${pageContext.request.contextPath}/vendedor/contacto">Contacto</a>
        </li>
        <li class="nav-item mx-2">
          <a class="nav-link active" href="${pageContext.request.contextPath}/vendedor/venta"><span class="fw-semibold">Venta</span></a>
        </li>
        <li class="nav-item ms-2">
          <a class="nav-link" href="${pageContext.request.contextPath}/vendedor/perfil">
            <i class="bi bi-person-circle fs-5"></i> Mi cuenta
          </a>
        </li>
      </ul>
    </div>
  </nav>

  <div class="venta-form-container" style="margin-top: 110px;">
    <div class="card-header text-center">
      <h4><i class="bi bi-cart-plus"></i> Registro de Venta</h4>
    </div>
    <div class="card-body">
        
        <h5><i class="bi bi-person"></i> Datos del Cliente</h5>
        <!-- Form para actualizar/guardar datos de cliente en sesión -->
        <form method="POST" action="${pageContext.request.contextPath}/vendedor/cliente/guardar" class="mb-2">
          <div class="row">
            <div class="col-md-6 mb-2 mb-md-0">
              <label for="nombreCliente" class="form-label">Nombre del Cliente</label>
              <input type="text" id="nombreCliente" name="clienteNombre" class="form-control" placeholder="Ej. Jazmin Garcia" required value="${cliente.nombre}">
            </div>
            <div class="col-md-6">
              <label for="dniCliente" class="form-label">DNI</label>
              <input type="text" id="dniCliente" name="clienteDni" class="form-control" placeholder="Ej. 74123594" maxlength="8" required value="${cliente.dni}">
            </div>
          </div>
          <div class="d-flex justify-content-end mt-3">
            <button type="submit" class="btn btn-outline-primary me-2">
              <i class="bi bi-save"></i> Guardar Cliente
            </button>
          </div>
        </form>

        <!-- Form separado para confirmar venta (usa cliente en sesión) -->
        <form method="POST" action="${pageContext.request.contextPath}/vendedor/venta/confirmar" class="mb-4 sync-cliente">
          <input type="hidden" name="clienteNombre" value="${cliente.nombre}">
          <input type="hidden" name="clienteDni" value="${cliente.dni}">
          <div class="d-flex justify-content-end mt-3">
            <button type="submit" class="btn btn-success">
              <i class="bi bi-check-circle"></i> Confirmar Venta
            </button>
          </div>
        </form>

        
        <h5 class="mb-3 mt-4"><i class="bi bi-box-seam"></i> Productos seleccionados</h5>

        <c:choose>
          <c:when test="${empty carrito}">
            <div class="alert alert-info">Tu carrito está vacío. 
              <a href="${pageContext.request.contextPath}/vendedor/catalogo">Ir al catálogo</a>
            </div>
          </c:when>
          <c:otherwise>
            <div class="row g-4 mb-3">
              <c:forEach var="item" items="${carrito}">
                <div class="col-12 col-md-6" id="item-${item.idProducto}">
                  <div class="position-relative p-4 rounded shadow-sm border d-flex gap-3 align-items-center">
                    <img src="${item.imagen}" alt="" style="width:72px;height:72px;object-fit:contain"/>
                    <div class="flex-grow-1">
                      <div class="fw-bold text-primary">${item.nombre}</div>
                      <div class="text-dark">Precio Unitario: <span class="text-secondary fw-bold">S/ ${item.precio}</span></div>
                      <div class="text-dark">
                        <form method="POST" action="${pageContext.request.contextPath}/vendedor/carrito/ajustar" class="d-inline sync-cliente">
                          <input type="hidden" name="idProducto" value="${item.idProducto}">
                          <input type="hidden" name="clienteNombre" value="${cliente.nombre}">
                          <input type="hidden" name="clienteDni" value="${cliente.dni}">
                          <small class="text-muted me-1">Cantidad:</small>
                          <button class="btn btn-outline-secondary py-0 px-1" type="submit" name="accion" value="dec" style="font-size: 0.7rem; min-width: 24px;">▼</button>
                          <span class="mx-1 fw-semibold" style="font-size: 0.9rem;">${item.cantidad}</span>
                          <button class="btn btn-outline-secondary py-0 px-1" type="submit" name="accion" value="inc" style="font-size: 0.7rem; min-width: 24px;">▲</button>
                        </form>
                      </div>
                      <div class="text-dark">Subtotal: <span class="text-secondary fw-bold">S/ <fmt:formatNumber value="${item.precio * item.cantidad}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span></div>
                    </div>
                    <a href="${pageContext.request.contextPath}/vendedor/carrito/eliminar/${item.idProducto}" class="btn btn-sm btn-outline-danger position-absolute top-0 end-0 m-2" onclick="return confirm('¿Eliminar este producto?');">
                      <i class="bi bi-trash"></i>
                    </a>
                  </div>
                </div>
              </c:forEach>
            </div>

            
            <div class="text-end mb-4">
              <p class="fw-bold fs-5 mb-0">Total a pagar: <span class="text-secondary">S/ <fmt:formatNumber value="${total}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span></p>
            </div>

            
            <div class="d-flex justify-content-center gap-3">
              <a href="${pageContext.request.contextPath}/vendedor/carrito/limpiar" class="btn btn-outline-danger" onclick="return confirm('¿Limpiar el carrito?');">
                <i class="bi bi-trash"></i> Limpiar Carrito
              </a>
            </div>
          </c:otherwise>
        </c:choose>

    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    // Sincroniza valores del cliente visible con los hidden inputs en formularios con la clase 'sync-cliente'
    (function(){
      var nombreInput = document.getElementById('nombreCliente');
      var dniInput = document.getElementById('dniCliente');
      if (!nombreInput || !dniInput) return;
      document.querySelectorAll('form.sync-cliente').forEach(function(f){
        f.addEventListener('submit', function(){
          var hiddenNombre = f.querySelector('input[name="clienteNombre"]');
          var hiddenDni = f.querySelector('input[name="clienteDni"]');
          if (hiddenNombre) hiddenNombre.value = nombreInput.value || '';
          if (hiddenDni) hiddenDni.value = dniInput.value || '';
        });
      });
    })();
  </script>
</body>
</html>