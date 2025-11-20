<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Métricas - DeportesX</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
  <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
</head>
<body>
  <div class="container my-5">
    <div class="d-flex justify-content-start mb-3">
      <a href="${pageContext.request.contextPath}/admin/gestion" class="btn btn-outline-secondary btn-sm">
        <i class="bi bi-arrow-left"></i> Volver
      </a>
    </div>
    
    <div class="text-center mb-4">
      <h2 class="fw-bold text-primary"><i class="bi bi-bar-chart-line-fill me-2"></i>Panel de Métricas</h2>
    </div>
    
    <!-- Resumen General -->
    <div class="row mb-4 g-3">
      <div class="col-md-3">
        <div class="card text-center p-3 bg-primary text-white metric-card">
          <h6><i class="bi bi-cart-check-fill me-2"></i>Total Ventas</h6>
          <h3>${totalVentas}</h3>
          <small>Registradas</small>
        </div>
      </div>
      <div class="col-md-3">
        <div class="card text-center p-3 bg-success text-white metric-card">
          <h6><i class="bi bi-cash-stack me-2"></i>Ingresos</h6>
          <h3>S/ <fmt:formatNumber value="${ingresosTotales}" pattern="#,##0"/></h3>
          <small>Total acumulado</small>
        </div>
      </div>
      <div class="col-md-3">
        <div class="card text-center p-3 bg-info text-white metric-card">
          <h6><i class="bi bi-box-seam me-2"></i>Productos</h6>
          <h3>${productosActivos}</h3>
          <small>Activos</small>
        </div>
      </div>
      <div class="col-md-3">
        <div class="card text-center p-3 bg-warning text-white metric-card">
          <h6><i class="bi bi-people-fill me-2"></i>Empleados</h6>
          <h3>${empleadosActivos}</h3>
          <small>Activos</small>
        </div>
      </div>
    </div>
    
    <div class="row g-4">
      <!-- Ventas Mensuales -->
      <div class="col-lg-6">
        <div class="card p-4">
          <h5 class="card-title mb-3 text-center">
            <i class="bi bi-graph-up me-2 text-success"></i>Ventas Mensuales 2025
          </h5>
          <div class="chart-container">
            <canvas id="chartVentas"></canvas>
          </div>
          <div class="text-center mt-2">
            <small class="text-muted"><i class="bi bi-info-circle me-1"></i>Meta mensual: S/ 2,000</small>
          </div>
        </div>
      </div>
      
      <!-- Categorías -->
      <div class="col-lg-6">
        <div class="card p-4">
          <h5 class="card-title mb-3 text-center">
            <i class="bi bi-pie-chart-fill me-2 text-primary"></i>Top Categorías
          </h5>
          <div class="chart-container">
            <canvas id="chartCategorias"></canvas>
          </div>
          <div class="text-center mt-2">
            <small class="text-muted">Noviembre 2025</small>
          </div>
        </div>
      </div>
      
      <!-- Asistencia -->
      <div class="col-lg-6">
        <div class="card p-4">
          <h5 class="card-title mb-3 text-center">
            <i class="bi bi-calendar-check me-2 text-info"></i>Asistencia de Empleados
          </h5>
          <div class="chart-container">
            <canvas id="chartAsistencia"></canvas>
          </div>
        </div>
      </div>
      
      <!-- Inventario -->
      <div class="col-lg-6">
        <div class="card p-4">
          <h5 class="card-title mb-3 text-danger text-center">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>Inventario Crítico
          </h5>
          <c:choose>
            <c:when test="${empty inventarioCritico}">
              <div class="alert alert-success text-center">
                <i class="bi bi-check-circle-fill me-2"></i>
                ¡Excelente! Stock controlado
              </div>
            </c:when>
            <c:otherwise>
              <div class="list-group">
                <c:forEach var="prod" items="${inventarioCritico}">
                  <div class="list-group-item d-flex justify-content-between align-items-center">
                    <span><i class="bi bi-box-seam me-2"></i>${prod.nombre}</span>
                    <span class="badge ${prod.stock < 3 ? 'bg-danger' : 'bg-warning'} rounded-pill">
                      ${prod.stock} uds
                    </span>
                  </div>
                </c:forEach>
              </div>
            </c:otherwise>
          </c:choose>
          <small class="text-muted d-block mt-3 text-center">
            <i class="bi bi-info-circle me-1"></i>Stock menor a 5 unidades
          </small>
        </div>
      </div>
    </div>
  </div>
  
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    // @ts-nocheck
    // Gráfico de Ventas Mensuales
    const ventasData = [
      <c:forEach var="venta" items="${ventasMensuales}" varStatus="status">
        {mes: ${venta.mes}, total: ${venta.total_mes}}<c:if test="${!status.last}">,</c:if>
      </c:forEach>
    ];
    
    const meses = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'];
    const ctxVentas = document.getElementById('chartVentas').getContext('2d');
    new Chart(ctxVentas, {
      type: 'bar',
      data: {
        labels: ventasData.map(v => meses[v.mes - 1]),
        datasets: [{
          label: 'Ventas',
          data: ventasData.map(v => v.total),
          backgroundColor: ventasData.map(v => v.total >= 2000 ? '#28a745' : (v.total >= 1400 ? '#ffc107' : '#dc3545')),
          borderColor: '#1976d2',
          borderWidth: 2,
          borderRadius: 8
        }, {
          label: 'Meta',
          data: ventasData.map(() => 2000),
          type: 'line',
          borderColor: '#ff9800',
          borderWidth: 3,
          borderDash: [10, 5],
          fill: false,
          pointRadius: 0
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: { display: true, position: 'top' },
          tooltip: {
            callbacks: {
              label: (context) => context.dataset.label + ': S/ ' + context.parsed.y.toLocaleString()
            }
          }
        },
        scales: {
          y: {
            beginAtZero: true,
            ticks: { callback: (value) => 'S/ ' + value }
          }
        }
      }
    });
    
    // Gráfico de Categorías
    const categoriasData = [
      <c:forEach var="cat" items="${categoriasMes}" varStatus="status">
        <c:if test="${status.index < 5}">
          {nombre: '${cat.nombre}', cantidad: ${cat.cantidad_vendida}}<c:if test="${!status.last && status.index < 4}">,</c:if>
        </c:if>
      </c:forEach>
    ];
    
    const ctxCategorias = document.getElementById('chartCategorias').getContext('2d');
    new Chart(ctxCategorias, {
      type: 'doughnut',
      data: {
        labels: categoriasData.map(c => c.nombre),
        datasets: [{
          data: categoriasData.map(c => c.cantidad),
          backgroundColor: ['#007bff', '#17a2b8', '#28a745', '#ffc107', '#6c757d'],
          borderWidth: 2,
          borderColor: '#fff'
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: { position: 'bottom' },
          tooltip: {
            callbacks: {
              label: (context) => {
                const total = context.dataset.data.reduce((a, b) => a + b, 0);
                const pct = ((context.parsed / total) * 100).toFixed(1);
                return context.label + ': ' + context.parsed + ' (' + pct + '%)';
              }
            }
          }
        }
      }
    });
    
    // Gráfico de Asistencia
    const asistenciaData = {
      anterior: ${asistencia.empleados_asistieron_mes_anterior},
      actual: ${asistencia.empleados_asistieron_mes},
      total: ${asistencia.total_empleados}
    };
    
    const pctAnt = (asistenciaData.anterior / asistenciaData.total * 100).toFixed(0);
    const pctAct = (asistenciaData.actual / asistenciaData.total * 100).toFixed(0);
    
    const ctxAsistencia = document.getElementById('chartAsistencia').getContext('2d');
    new Chart(ctxAsistencia, {
      type: 'bar',
      data: {
        labels: ['Octubre', 'Noviembre'],
        datasets: [{
          label: 'Asistencia (%)',
          data: [pctAnt, pctAct],
          backgroundColor: ['#ffc107', pctAct >= 80 ? '#28a745' : '#ffc107'],
          borderColor: '#1976d2',
          borderWidth: 2,
          borderRadius: 8
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: { display: false },
          tooltip: {
            callbacks: {
              label: (context) => 'Asistencia: ' + context.parsed.y + '%'
            }
          }
        },
        scales: {
          y: {
            beginAtZero: true,
            max: 100,
            ticks: { callback: (value) => value + '%' }
          }
        }
      }
    });
  </script>
</body>
</html>
