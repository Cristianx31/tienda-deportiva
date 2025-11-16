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
  <style>
    .chart-container {
      position: relative;
      height: 300px;
      margin-bottom: 20px;
    }
    .metric-card {
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    .metric-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 20px rgba(0,0,0,0.15);
    }
  </style>
</head>
<body>
  <div class="container my-5">
    <div class="d-flex justify-content-start mb-3">
      <a href="${pageContext.request.contextPath}/admin/gestion" class="btn btn-outline-secondary btn-sm">
        <i class="bi bi-arrow-left"></i> Volver
      </a>
    </div>
    <div class="metricas-header mb-4">
      <i class="bi bi-bar-chart-line-fill"></i>
      <h2 class="text-center fw-bold text-primary">Métricas de la Tienda Deportiva</h2>
    </div>
    
    <!-- Resumen General -->
    <div class="row mb-4">
      <div class="col-md-3">
        <div class="card text-center p-3 bg-primary text-white metric-card">
          <h6><i class="bi bi-cart-check-fill me-2"></i>Total Ventas</h6>
          <h3>${totalVentas}</h3>
          <small>Todas las ventas</small>
        </div>
      </div>
      <div class="col-md-3">
        <div class="card text-center p-3 bg-success text-white metric-card">
          <h6><i class="bi bi-cash-stack me-2"></i>Ingresos Totales</h6>
          <h3>S/ <fmt:formatNumber value="${ingresosTotales}" pattern="#,##0.00"/></h3>
          <small>Ventas completadas</small>
        </div>
      </div>
      <div class="col-md-3">
        <div class="card text-center p-3 bg-info text-white metric-card">
          <h6><i class="bi bi-box-seam me-2"></i>Productos Activos</h6>
          <h3>${productosActivos}</h3>
          <small>En inventario</small>
        </div>
      </div>
      <div class="col-md-3">
        <div class="card text-center p-3 bg-warning text-white metric-card">
          <h6><i class="bi bi-people-fill me-2"></i>Empleados Activos</h6>
          <h3>${empleadosActivos}</h3>
          <small>Personal activo</small>
        </div>
      </div>
    </div>
    
    <div class="dashboard-grid-metricas">
      <!-- Ventas Mensuales con Gráfico -->
      <div class="col-lg-6 col-md-6 d-flex">
        <div class="card-metric p-4 flex-fill">
          <h5 class="card-title mb-4 text-center">
            <i class="bi bi-graph-up-arrow me-2"></i>Ventas Mensuales vs Meta
          </h5>
          <div class="chart-container">
            <canvas id="chartVentasMensuales"></canvas>
          </div>
          <div class="text-center mt-3">
            <span class="badge bg-success me-2">Ventas Reales</span>
            <span class="badge bg-warning">Meta Mensual: S/ 2,000</span>
          </div>
          <small class="text-muted d-block mt-3 text-center">Actualizado: Noviembre 2025</small>
        </div>
      </div>
      <!-- Categoría Más Vendida (Mes Actual) con Gráfico -->
      <div class="col-lg-6 col-md-6 d-flex">
        <div class="card-metric p-4 flex-fill">
          <h5 class="card-title mb-4 text-center">
            <i class="bi bi-pie-chart-fill me-2"></i>Categorías Más Vendidas (Mes Actual)
          </h5>
          <div class="chart-container">
            <canvas id="chartCategorias"></canvas>
          </div>
          <small class="text-muted d-block mt-3 text-center">Top 5 categorías del mes</small>
        </div>
      </div>
      <!-- Asistencia de Empleados con Gráfico -->
      <div class="col-lg-6 col-md-6 d-flex">
        <div class="card-metric p-4 flex-fill">
          <h5 class="card-title mb-4 text-center">
            <i class="bi bi-calendar-check me-2"></i>Asistencia de Empleados
          </h5>
          <div class="chart-container">
            <canvas id="chartAsistencia"></canvas>
          </div>
          <div class="text-center mt-3">
            <c:set var="totalEmpleados" value="${asistencia.total_empleados}"/>
            <c:set var="asistMes" value="${asistencia.empleados_asistieron_mes}"/>
            <c:set var="porcMes" value="${totalEmpleados > 0 ? (asistMes * 100.0 / totalEmpleados) : 0}"/>
            <span class="badge ${porcMes >= 80 ? 'bg-success' : 'bg-warning'}">
              <fmt:formatNumber value="${porcMes}" pattern="#0.0"/>% asistencia este mes
            </span>
          </div>
          <small class="text-muted d-block mt-3 text-center">Noviembre 2025</small>
        </div>
      </div>
      <!-- Inventario Crítico -->
      <div class="col-lg-6 col-md-6 d-flex">
        <div class="card-metric p-4 flex-fill">
          <h5 class="card-title mb-4 text-danger">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>Inventario Crítico
          </h5>
          <c:choose>
            <c:when test="${empty inventarioCritico}">
              <p class="text-success">
                <i class="bi bi-check-circle-fill me-2"></i>
                ¡Excelente! No hay productos con stock crítico
              </p>
            </c:when>
            <c:otherwise>
              <ul class="list-group mb-3">
                <c:forEach var="prod" items="${inventarioCritico}">
                  <li class="list-group-item d-flex justify-content-between align-items-center">
                    ${prod.nombre}
                    <span class="badge ${prod.stock < 3 ? 'bg-danger' : 'bg-warning'} rounded-pill">
                      ${prod.stock}
                    </span>
                  </li>
                </c:forEach>
              </ul>
            </c:otherwise>
          </c:choose>
          <small class="text-muted">Productos con stock menor a 5 unidades</small>
        </div>
      </div>
    </div>
  </div>

  <script>
    // Datos de ventas mensuales
    const ventasMensuales = [
      <c:forEach var="venta" items="${ventasMensuales}" varStatus="status">
        {
          mes: ${venta.mes},
          total: ${venta.total_mes}
        }<c:if test="${!status.last}">,</c:if>
      </c:forEach>
    ];

    // Datos de categorías
    const categorias = [
      <c:forEach var="cat" items="${categoriasMes}" varStatus="status">
        <c:if test="${status.index < 5}">
        {
          nombre: '${cat.nombre}',
          cantidad: ${cat.cantidad_vendida}
        }<c:if test="${status.index < 4 && status.count < fn:length(categoriasMes)}">,</c:if>
        </c:if>
      </c:forEach>
    ];

    // Datos de asistencia
    const asistenciaData = {
      mesAnterior: ${asistencia.empleados_asistieron_mes_anterior},
      mesActual: ${asistencia.empleados_asistieron_mes},
      total: ${asistencia.total_empleados}
    };

    const mesesNombres = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'];
    const metaMensual = 2000;

    // Preparar datos para el gráfico de ventas
    const ventasLabels = ventasMensuales.map(v => mesesNombres[v.mes - 1]);
    const ventasData = ventasMensuales.map(v => v.total);
    const metaData = ventasMensuales.map(() => metaMensual);

    // Gráfico de Ventas Mensuales vs Meta
    const ctxVentas = document.getElementById('chartVentasMensuales').getContext('2d');
    new Chart(ctxVentas, {
      type: 'bar',
      data: {
        labels: ventasLabels,
        datasets: [
          {
            label: 'Ventas Reales',
            data: ventasData,
            backgroundColor: 'rgba(25, 135, 84, 0.8)',
            borderColor: 'rgba(25, 135, 84, 1)',
            borderWidth: 2,
            borderRadius: 5
          },
          {
            label: 'Meta Mensual',
            data: metaData,
            backgroundColor: 'rgba(255, 193, 7, 0.3)',
            borderColor: 'rgba(255, 193, 7, 1)',
            borderWidth: 2,
            borderDash: [5, 5],
            type: 'line'
          }
        ]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            display: true,
            position: 'top'
          },
          tooltip: {
            callbacks: {
              label: function(context) {
                return context.dataset.label + ': S/ ' + context.parsed.y.toFixed(2);
              }
            }
          }
        },
        scales: {
          y: {
            beginAtZero: true,
            ticks: {
              callback: function(value) {
                return 'S/ ' + value;
              }
            }
          }
        }
      }
    });

    // Gráfico de Categorías (Dona)
    const ctxCategorias = document.getElementById('chartCategorias').getContext('2d');
    const coloresCategorias = [
      'rgba(25, 135, 84, 0.8)',
      'rgba(13, 202, 240, 0.8)',
      'rgba(220, 53, 69, 0.8)',
      'rgba(13, 110, 253, 0.8)',
      'rgba(108, 117, 125, 0.8)'
    ];
    
    new Chart(ctxCategorias, {
      type: 'doughnut',
      data: {
        labels: categorias.map(c => c.nombre),
        datasets: [
          {
            data: categorias.map(c => c.cantidad),
            backgroundColor: coloresCategorias,
            borderWidth: 2,
            borderColor: '#fff'
          }
        ]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            position: 'bottom'
          },
          tooltip: {
            callbacks: {
              label: function(context) {
                const total = context.dataset.data.reduce((a, b) => a + b, 0);
                const porcentaje = ((context.parsed / total) * 100).toFixed(1);
                return context.label + ': ' + context.parsed + ' uds (' + porcentaje + '%)';
              }
            }
          }
        }
      }
    });

    // Gráfico de Asistencia (Barras)
    const ctxAsistencia = document.getElementById('chartAsistencia').getContext('2d');
    const porcMesAnt = asistenciaData.total > 0 ? (asistenciaData.mesAnterior / asistenciaData.total * 100) : 0;
    const porcMesAct = asistenciaData.total > 0 ? (asistenciaData.mesActual / asistenciaData.total * 100) : 0;
    
    new Chart(ctxAsistencia, {
      type: 'bar',
      data: {
        labels: ['Mes Anterior', 'Mes Actual'],
        datasets: [
          {
            label: 'Asistencia (%)',
            data: [porcMesAnt, porcMesAct],
            backgroundColor: [
              'rgba(255, 193, 7, 0.6)',
              'rgba(25, 135, 84, 0.8)'
            ],
            borderColor: [
              'rgba(255, 193, 7, 1)',
              'rgba(25, 135, 84, 1)'
            ],
            borderWidth: 2,
            borderRadius: 5
          }
        ]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            display: false
          },
          tooltip: {
            callbacks: {
              label: function(context) {
                return 'Asistencia: ' + context.parsed.y.toFixed(1) + '%';
              }
            }
          }
        },
        scales: {
          y: {
            beginAtZero: true,
            max: 100,
            ticks: {
              callback: function(value) {
                return value + '%';
              }
            }
          }
        }
      }
    });
  </script>
</body>
</html>
