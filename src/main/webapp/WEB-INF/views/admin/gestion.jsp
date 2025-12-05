<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Panel del Administrador - DeportesX</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
  <!-- NAVBAR PRINCIPAL -->
  <nav class="navbar navbar-dark bg-dark fixed-top">
    <div class="container">
      <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/gestion">
        <span style="color:#1976d2;font-weight:900;">X</span>
        <span style="color:#fff;">DEPORTES x</span>
      </a>
      <button class="btn btn-outline-light" type="button" data-bs-toggle="offcanvas" data-bs-target="#menuLateral">
        <i class="bi bi-list fs-4"></i>
      </button>
    </div>
  </nav>

  <!-- MENÚ LATERAL SOLO PARA ADMIN -->
  <div class="offcanvas offcanvas-end" tabindex="-1" id="menuLateral">
    <div class="offcanvas-header">
      <h5 class="offcanvas-title">Panel Administrador</h5>
      <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"></button>
    </div>
    <div class="offcanvas-body">
      <a href="${pageContext.request.contextPath}/admin/gestion"><i class="bi bi-gear"></i> Gestión</a>
      <a href="${pageContext.request.contextPath}/admin/metricas"><i class="bi bi-bar-chart-line"></i> Métricas</a>
      <a href="${pageContext.request.contextPath}/admin/perfil-admin"><i class="bi bi-person-badge"></i> Mi cuenta</a>
    </div>
  </div>

  <div class="container my-5" style="margin-top: 110px; max-width: 1100px;">
    <div class="card shadow-lg gestion-card mx-auto">
      <div class="card-header text-center py-4">
        <h2><i class="bi bi-person-gear"></i> Gestión </h2>
      </div>
      <div class="card-body">
        <ul class="nav nav-tabs mb-4" id="gestionTabs" role="tablist">
          <li class="nav-item" role="presentation">
            <button class="nav-link ${activeTab == 'productos' ? 'active' : ''}" id="productos-tab" data-bs-toggle="tab" data-bs-target="#productosTab" type="button" role="tab" aria-controls="productosTab" aria-selected="${activeTab == 'productos' ? 'true' : 'false'}">
              <i class="bi bi-box-seam"></i> Productos
            </button>
          </li>
          <li class="nav-item" role="presentation">
            <button class="nav-link ${activeTab == 'ventas' ? 'active' : ''}" id="ventas-tab" data-bs-toggle="tab" data-bs-target="#ventasTab" type="button" role="tab" aria-controls="ventasTab" aria-selected="${activeTab == 'ventas' ? 'true' : 'false'}">
              <i class="bi bi-cash-coin"></i> Ventas
            </button>
          </li>
          <li class="nav-item" role="presentation">
            <button class="nav-link ${activeTab == 'categorias' ? 'active' : ''}" id="categorias-tab" data-bs-toggle="tab" data-bs-target="#categoriasTab" type="button" role="tab" aria-controls="categoriasTab" aria-selected="${activeTab == 'categorias' ? 'true' : 'false'}">
              <i class="bi bi-tags"></i> Categorías
            </button>
          </li>
          <li class="nav-item" role="presentation">
            <button class="nav-link ${activeTab == 'empleados' ? 'active' : ''}" id="empleados-tab" data-bs-toggle="tab" data-bs-target="#empleadosTab" type="button" role="tab" aria-controls="empleadosTab" aria-selected="${activeTab == 'empleados' ? 'true' : 'false'}">
              <i class="bi bi-people-fill"></i> Usuarios
            </button>
          </li>
          <li class="nav-item" role="presentation">
            <button class="nav-link ${activeTab == 'asistencia' ? 'active' : ''}" id="asistencia-tab" data-bs-toggle="tab" data-bs-target="#asistenciaTab" type="button" role="tab" aria-controls="asistenciaTab" aria-selected="${activeTab == 'asistencia' ? 'true' : 'false'}">
              <i class="bi bi-calendar-check"></i> Asistencia
            </button>
          </li>
        </ul>
        <div class="tab-content" id="gestionTabsContent">
          <div class="tab-pane fade ${activeTab == 'productos' ? 'show active' : ''}" id="productosTab" role="tabpanel" aria-labelledby="productos-tab">
            
            <!-- Mensajes de éxito o error -->
            <c:if test="${not empty success}">
              <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill"></i> ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
              </div>
            </c:if>
            <c:if test="${not empty error}">
              <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill"></i> ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
              </div>
            </c:if>
            
            <div class="d-flex justify-content-between align-items-center mb-3">
              <h4><i class="bi bi-box-seam"></i> Gestión de Productos</h4>
              <a href="${pageContext.request.contextPath}/admin/producto-crear" class="btn btn-success btn-sm">
                <i class="bi bi-plus-circle"></i> Nuevo Producto
              </a>
            </div>
            <table class="table table-hover text-center align-middle">
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Nombre</th>
                  <th>Imagen</th>
                  <th>Precio</th>
                  <th>Estado</th>
                  <th>Acciones</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="producto" items="${productos}">
                  <tr>
                    <td>${producto.idProducto}</td>
                    <td>${producto.nombre}</td>
                    <td>
                      <img src="${producto.imagen}" alt="Imagen" style="width:50px; height:50px; object-fit:cover;">
                    </td>
                    <td>S/ ${producto.precio}</td>
                    <td>
                      <c:choose>
                        <c:when test="${producto.estado}">
                          <span class="badge bg-success">Activo</span>
                        </c:when>
                        <c:otherwise>
                          <span class="badge bg-secondary">Inactivo</span>
                        </c:otherwise>
                      </c:choose>
                    </td>
                    <td>
                      <a href="${pageContext.request.contextPath}/admin/producto-editar/${producto.idProducto}" class="btn btn-outline-primary btn-sm">
                        <i class="bi bi-pencil"></i> Editar
                      </a>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
          <div class="tab-pane fade ${activeTab == 'ventas' ? 'show active' : ''}" id="ventasTab" role="tabpanel" aria-labelledby="ventas-tab">
            <div class="mb-3">
              <h4><i class="bi bi-cash-coin"></i> Ventas</h4>
            </div>
            <table class="table table-hover text-center align-middle">
              <thead>
                <tr>
                  <th>ID Venta</th>
                  <th>Cliente</th>
                  <th>Fecha</th>
                  <th>Empleado</th> 
                  <th>Total</th>
                  <th>Acciones</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="venta" items="${ventas}">
                  <tr>
                    <td>${venta.idVenta}</td>
                    <td>${venta.nombreCliente}</td>
                    <td>${venta.fecha}</td>
                    <td>${venta.nombreEmpleado}</td> 
                    <td>S/ ${venta.total}</td>
                  <td>
                      <a href="${pageContext.request.contextPath}/admin/venta-detalle/${venta.idVenta}" class="btn btn-outline-primary btn-sm">
                        <i class="bi bi-eye"></i> Ver
                      </a>
                  </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
          <div class="tab-pane fade ${activeTab == 'categorias' ? 'show active' : ''}" id="categoriasTab" role="tabpanel" aria-labelledby="categorias-tab">
            
            <!-- Mensajes de éxito o error para Categorías -->
            <c:if test="${not empty successCategoria}">
              <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill"></i> ${successCategoria}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
              </div>
            </c:if>
            <c:if test="${not empty errorCategoria}">
              <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill"></i> ${errorCategoria}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
              </div>
            </c:if>
            
            <div class="d-flex justify-content-between align-items-center mb-3">
              <h4><i class="bi bi-tags"></i> Gestión de Categorías</h4>
              <a href="${pageContext.request.contextPath}/admin/categoria-crear" class="btn btn-success btn-sm">
                <i class="bi.bi-plus-circle"></i> Nueva Categoría
              </a>
            </div>
            <table class="table table-hover text-center align-middle">
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Nombre</th>
                  <th>Estado</th>
                  <th>Acciones</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="categoria" items="${categorias}">
                  <tr>
                    <td>${categoria.idCategoria}</td>
                    <td>${categoria.nombre}</td>
                    <td>
                      <c:choose>
                        <c:when test="${categoria.estado}">
                          <span class="badge bg-success">Activa</span>
                        </c:when>
                        <c:otherwise>
                          <span class="badge bg-secondary">Inactiva</span>
                        </c:otherwise>
                      </c:choose>
                    </td>
                    <td>
                      <a href="${pageContext.request.contextPath}/admin/categoria-editar/${categoria.idCategoria}" class="btn btn-outline-primary btn-sm">
                        <i class="bi bi-pencil"></i> Editar
                      </a>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
          <div class="tab-pane fade ${activeTab == 'empleados' ? 'show active' : ''}" id="empleadosTab" role="tabpanel" aria-labelledby="empleados-tab">
            
            <!-- Mensajes de éxito o error para Empleados -->
            <c:if test="${not empty successEmpleado}">
              <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill"></i> ${successEmpleado}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
              </div>
            </c:if>
            <c:if test="${not empty errorEmpleado}">
              <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill"></i> ${errorEmpleado}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
              </div>
            </c:if>
            
            <div class="d-flex justify-content-between align-items-center mb-3">
              <h4><i class="bi bi-people-fill"></i> Usuarios</h4>
              <a href="${pageContext.request.contextPath}/admin/empleado-crear" class="btn btn-success btn-sm">
                <i class="bi bi-person-plus"></i> Nuevo Usuario
              </a>
            </div>
            <c:if test="${param.error == 'adminNoPuedeDesactivarse'}">
              <div class="alert alert-danger mt-3" role="alert">
                No puedes desactivar tu propia cuenta de administrador.
              </div>
            </c:if>
            <table class="table table-hover text-center align-middle">
              <thead>
                <tr>
                  <th>ID</th>
                  <th>DNI</th>
                  <th>Nombre Completo</th>
                  <th>Cargo</th>
                  <th>Correo</th>
                  <th>Horario Entrada</th>
                  <th>Horario Salida</th>
                  <th>Estado</th>
                  <th>Acciones</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="empleado" items="${empleados}">
                  <tr>
                    <td>${empleado.id_usuario}</td>
                    <td>${empleado.dni}</td>
                    <td>${empleado.nombre_completo}</td>
                    <td>
                      <c:choose>
                        <c:when test="${empleado.cargo == 'Administrador'}">
                          <span class="badge bg-danger">${empleado.cargo}</span>
                        </c:when>
                        <c:otherwise>
                          <span class="badge bg-primary">${empleado.cargo}</span>
                        </c:otherwise>
                      </c:choose>
                    </td>
                    <td>${empleado.correo}</td>
                    <td>
                      <c:choose>
                        <c:when test="${empty empleado.hora_entrada}">
                          <span class="text-muted">-</span>
                        </c:when>
                        <c:otherwise>
                          <span class="badge bg-info">${empleado.hora_entrada}</span>
                        </c:otherwise>
                      </c:choose>
                    </td>
                    <td>
                      <c:choose>
                        <c:when test="${empty empleado.hora_salida}">
                          <span class="text-muted">-</span>
                        </c:when>
                        <c:otherwise>
                          <span class="badge bg-info">${empleado.hora_salida}</span>
                        </c:otherwise>
                      </c:choose>
                    </td>
                    <td>
                      <c:choose>
                        <c:when test="${empleado.estado}">
                          <span class="badge bg-success">Activo</span>
                        </c:when>
                        <c:otherwise>
                          <span class="badge bg-secondary">Inactivo</span>
                        </c:otherwise>
                      </c:choose>
                    </td>
                    <td>
                      <a href="${pageContext.request.contextPath}/admin/empleado-editar/${empleado.id_usuario}" class="btn btn-outline-primary btn-sm">
                        <i class="bi bi-pencil"></i> Editar
                      </a>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
          <div class="tab-pane fade ${activeTab == 'asistencia' ? 'show active' : ''}" id="asistenciaTab" role="tabpanel" aria-labelledby="asistencia-tab">
            
            <!-- Mensajes de éxito o error para Asistencia -->
            <c:if test="${not empty successAsistencia}">
              <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill"></i> ${successAsistencia}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
              </div>
            </c:if>
            <c:if test="${not empty errorAsistencia}">
              <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill"></i> ${errorAsistencia}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
              </div>
            </c:if>
            
            <div class="d-flex justify-content-between align-items-center mb-3">
              <h4><i class="bi bi-calendar-check"></i> Historial de Asistencia</h4>
            </div>
            <table class="table table-hover text-center align-middle">
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Usuario</th>
                  <th>Fecha</th>
                  <th>Hora Ingreso</th>
                  <th>Estado de Entrada</th>
                  <th>Hora Salida</th>
                  <th>Estado de Salida</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="asistencia" items="${asistencias}">
                  <c:set var="usuarioAsistencia" value="" />
                  <c:forEach var="usuario" items="${empleados}">
                    <c:if test="${usuario.id_usuario == asistencia.idUsuario}">
                      <c:set var="usuarioAsistencia" value="${usuario}" />
                    </c:if>
                  </c:forEach>
                  <tr>
                    <td>${asistencia.idAsistencia}</td>
                    <td>${usuarioAsistencia.nombre_completo}</td>
                    <td>${asistencia.fecha}</td>
                    <td>${asistencia.horaIngreso}</td>
                    <td>
                      <c:choose>
                        <c:when test="${asistencia.horaIngreso > usuarioAsistencia.hora_entrada}">
                          <span class="badge bg-danger">Tarde</span>
                        </c:when>
                        <c:otherwise>
                          <span class="badge bg-success">A Tiempo</span>
                        </c:otherwise>
                      </c:choose>
                    </td>
                    <td>${asistencia.horaSalida}</td>
                    <td>
                      <c:choose>
                        <c:when test="${asistencia.horaSalida == null}">
                          <span class="badge bg-secondary">-</span>
                        </c:when>
                        <c:when test="${asistencia.horaSalida < usuarioAsistencia.hora_salida}">
                          <span class="badge bg-warning">Incompleto</span>
                        </c:when>
                        <c:otherwise>
                          <span class="badge bg-success">Completo</span>
                        </c:otherwise>
                      </c:choose>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>