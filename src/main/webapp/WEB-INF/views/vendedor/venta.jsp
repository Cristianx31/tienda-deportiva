<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
  <!-- Navbar -->
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
          <a class="nav-link active" href="${pageContext.request.contextPath}/vendedor/venta"><i class="bi bi-cart3 fs-5"></i></a>
        </li>
        <li class="nav-item ms-2">
          <a class="nav-link" href="${pageContext.request.contextPath}/vendedor/perfil">
            <i class="bi bi-person-circle fs-5"></i> Mi cuenta
          </a>
        </li>
      </ul>
    </div>
  </nav>

  <div class="venta-form-container" style="margin-top: 150px;">
    <div class="card-header text-center">
      <h4><i class="bi bi-cart-plus"></i> Registro de Venta</h4>
    </div>
    <div class="card-body">
      <form>
        <!-- Datos del cliente -->
        <h5><i class="bi bi-person"></i> Datos del Cliente</h5>
        <div class="row">
          <div class="col-md-6 mb-2 mb-md-0">
            <label for="nombreCliente" class="form-label">Nombre del Cliente</label>
            <input type="text" id="nombreCliente" class="form-control" placeholder="Ej. Jazmin Garcia" autocomplete="name" required>
            <div class="invalid-feedback">Ingresa un nombre válido (mínimo 3 letras).</div>
          </div>
          <div class="col-md-6">
            <label for="dniCliente" class="form-label">DNI</label>
            <input type="text" id="dniCliente" class="form-control" placeholder="Ej. 74123594" inputmode="numeric" maxlength="8" required>
            <div class="invalid-feedback">El DNI debe tener 8 dígitos numéricos.</div>
          </div>
        </div>

        <!-- Productos seleccionados (dinámico) -->
        <h5 class="mb-3"><i class="bi bi-box-seam"></i> Productos seleccionados</h5>
        <div id="cart-list" class="row g-4 mb-3"></div>

        <!-- Total general -->
        <div class="text-end mb-4">
          <p class="fw-bold fs-5 mb-0">Total a pagar: <span id="cart-total" class="text-secondary">S/ 0.00</span></p>
        </div>

        <!-- Botones -->
        <div class="d-flex justify-content-center gap-3">
          <a href="${pageContext.request.contextPath}/vendedor/venta-detalle" id="btnConfirmar" class="btn btn-success">
            <i class="bi bi-check-circle"></i> Confirmar Venta
          </a>
          <a href="${pageContext.request.contextPath}/vendedor/catalogo" class="btn btn-outline-secondary">
            <i class="bi bi-arrow-left"></i> Volver al Catálogo
          </a>
        </div>
      </form>
    </div>
  </div>
  <script src="${pageContext.request.contextPath}/assets/js/cart.js"></script>
  <script>
    (function(){
      const list = document.getElementById('cart-list');
      const totalEl = document.getElementById('cart-total');

      function render(){
        const items = Cart.getCart();
        list.innerHTML = '';
        if(items.length === 0){
          list.innerHTML = '<div class="col-12"><div class="alert alert-info">Tu carrito está vacío.</div></div>';
        }
        items.forEach(function(i){
          const col = document.createElement('div');
          col.className = 'col-12 col-md-6';
          col.innerHTML =
            '<div class="position-relative p-4 rounded shadow-sm border d-flex gap-3 align-items-center">' +
              '<img src="' + (i.image || '') + '" alt="" style="width:72px;height:72px;object-fit:contain"/>' +
              '<div class="flex-grow-1">' +
                '<div class="fw-bold text-primary">' + i.name + '</div>' +
                '<div class="text-dark">Precio Unitario: <span class="text-secondary fw-bold">S/ ' + Cart.formatCurrency(i.price) + '</span></div>' +
                '<div class="text-dark">Cantidad: <input data-id="' + i.id + '" type="number" class="form-control w-auto d-inline-block cart-qty" min="1" value="' + (i.qty||1) + '"></div>' +
                '<div class="text-dark">Subtotal: <span class="text-secondary fw-bold">S/ ' + Cart.formatCurrency(i.price * (i.qty||1)) + '</span></div>' +
              '</div>' +
              '<button data-id="' + i.id + '" class="btn btn-sm btn-outline-danger btn-remove position-absolute top-0 end-0 m-2"><i class="bi bi-trash"></i></button>' +
            '</div>';
          list.appendChild(col);
        });
        totalEl.textContent = 'S/ ' + Cart.formatCurrency(Cart.total());
      }

      // Events
      list.addEventListener('change', function(e){
        if(e.target.classList.contains('cart-qty')){
          Cart.updateQty(e.target.dataset.id, e.target.value);
          render();
        }
      });
      list.addEventListener('click', function(e){
        const btn = e.target.closest('.btn-remove');
        if(btn){
          const id = btn.dataset.id;
          Cart.removeItem(id);
          render();
        }
      });

      document.getElementById('btnConfirmar').addEventListener('click', function(e){
        // Validaciones simples
        const name = document.getElementById('nombreCliente');
        const dni = document.getElementById('dniCliente');
        const items = Cart.getCart();
        let ok = true;

        // Nombre: mínimo 3 letras (solo letras y espacios)
        const nameOk = /^[A-Za-zÁÉÍÓÚÑáéíóúñ ]{3,}$/.test(name.value.trim());
        name.classList.toggle('is-invalid', !nameOk);
        if(!nameOk) ok = false;

        // DNI: 8 dígitos
        const dniOk = /^\d{8}$/.test(dni.value.trim());
        dni.classList.toggle('is-invalid', !dniOk);
        if(!dniOk) ok = false;

        // Carrito no vacío
        if(items.length === 0){
          alert('Tu carrito está vacío. Agrega productos antes de confirmar.');
          ok = false;
        }

        if(!ok){
          e.preventDefault();
          return;
        }

        // Guardar la venta en sessionStorage para mostrar en detalle
        const lastSale = {
          id: Date.now(),
          date: new Date().toISOString().slice(0,10),
          client: name.value.trim(),
          dni: dni.value.trim(),
          items: items,
          total: Cart.total()
        };
        sessionStorage.setItem('lastSale', JSON.stringify(lastSale));
        // Agregar al historial de ventas (sales)
        try {
          const history = JSON.parse(sessionStorage.getItem('sales') || '[]');
          history.push(lastSale);
          sessionStorage.setItem('sales', JSON.stringify(history));
        } catch(_) {}
        Cart.clear();
      });

      render();
    })();
  </script>
</body>
</html>