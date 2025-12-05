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
    .chart-container { position: relative; height: 380px; }
    .metric-card {
      box-shadow: 0 4px 6px rgba(0,0,0,0.1);
      transition: transform 0.2s;
    }
    .metric-card:hover {
      transform: translateY(-5px);
    }
    .section-title {
      border-bottom: 3px solid;
      padding-bottom: 15px;
      margin-bottom: 30px;
      margin-top: 40px;
    }
    .badge-custom {
      font-size: 0.85rem;
      padding: 8px 12px;
    }
  </style>
</head>
<body>
  <div class="container-fluid my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <a href="${pageContext.request.contextPath}/admin/gestion" class="btn btn-outline-secondary btn-sm">
        <i class="bi bi-arrow-left"></i> Volver
      </a>
      <h2 class="fw-bold text-primary mb-0"><i class="bi bi-bar-chart-line-fill me-2"></i>Panel de Métricas Integral</h2>
      <div></div>
    </div>
    
    <!-- ===== RESUMEN GENERAL ===== -->
    <div class="row mb-5 g-3">
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

    <!-- Datos en JSON para facilitar parseo en JavaScript -->
    <script type="application/json" id="ventasDiarias30Data">
    [
    <c:forEach var="dia" items="${ventasDiarias30}" varStatus="st">
      {"fecha_venta": "${dia.fecha_venta}", "total_dia": ${dia.total_dia}, "cantidad_ventas": ${dia.cantidad_ventas}, "empleados_activos": ${dia.empleados_activos}}<c:if test="${!st.last}">,</c:if>
    </c:forEach>
    ]
    </script>
    <script type="application/json" id="asistenciaSemanalData">
    [
    <c:forEach var="semana" items="${asistenciaSemanal}" varStatus="st">
      {"num_semana": ${semana.num_semana}, "anio": ${semana.anio}, "nombre_empleado": "${semana.nombre_empleado}", "total_asistencias": ${semana.total_asistencias}, "llegadas_tarde": ${semana.llegadas_tarde}}<c:if test="${!st.last}">,</c:if>
    </c:forEach>
    ]
    </script>
    <script type="application/json" id="ventasPorCategoriaData">
    [
    <c:forEach var="cat" items="${ventasPorCategoria}" varStatus="st">
      {"mes": ${cat.mes}, "anio": ${cat.anio}, "nombre_categoria": "${cat.nombre_categoria}", "total_ventas": ${cat.total_ventas}, "cantidad_productos": ${cat.cantidad_productos}, "numero_transacciones": ${cat.numero_transacciones}}<c:if test="${!st.last}">,</c:if>
    </c:forEach>
    ]
    </script>

    <!-- ===== RESUMEN DE CUMPLIMIENTO ===== -->
    <div class="row mb-4 g-3">
      <div class="col-md-4">
        <div class="card text-center p-3 metric-card">
          <h6>Meta Mensual</h6>
          <h5>S/ <fmt:formatNumber value="${metaMensual}" pattern="#,##0"/></h5>
          <small>Meta fija</small>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card text-center p-3 metric-card">
          <h6>Total Mes Actual</h6>
          <h5>S/ <fmt:formatNumber value="${totalMesActual}" pattern="#,##0.00"/></h5>
          <small>Ingresos del mes</small>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card text-center p-3 metric-card">
          <h6>Cumplimiento</h6>
          <h5>
            <c:choose>
              <c:when test="${cumpleMeta}">
                <span class="badge bg-success">Cumple la meta</span>
              </c:when>
              <c:otherwise>
                <span class="badge bg-danger">No cumple la meta</span>
              </c:otherwise>
            </c:choose>
          </h5>
          <small>Ticket promedio: <c:out value="${ticketPromedio}"/> S/</small>
        </div>
      </div>
    </div>

    <!-- ===== MÉTRICAS DE SERIE DE TIEMPO ===== -->
    <h4 class="section-title border-success text-success">
      <i class="bi bi-clock-history me-2"></i>Métricas de Serie de Tiempo
    </h4>

    <!-- Métrica 1: Ventas Diarias (Últimos 30 días) -->
    <div class="row g-4 mb-5">
      <div class="col-lg-12">
        <div class="card p-4">
          <div class="d-flex align-items-center mb-3">
            <h5 class="card-title mb-0">
              <i class="bi bi-calendar-day me-2 text-info"></i>Ventas Diarias (Últimos 30 días)
            </h5>
          </div>
          <small class="text-muted d-block mb-3">
            Qué mide: Total de ventas por día | Unidad: Monto en dinero | Objetivo: Detectar patrones y picos de actividad
          </small>
          <div class="chart-container">
            <canvas id="chartVentasDiarias30"></canvas>
          </div>
          <div class="mt-2">
            <small class="text-muted"><i class="bi bi-info-circle me-1"></i>Gráfico de barras por día con línea del promedio diario</small>
          </div>
        </div>
      </div>
    </div>

    <!-- Métrica 2: Asistencia Acumulada Semanal -->
    <div class="row g-4 mb-5">
      <div class="col-lg-12">
        <div class="card p-4">
          <div class="d-flex align-items-center mb-3">
            <h5 class="card-title mb-0">
              <i class="bi bi-calendar-week me-2 text-warning"></i>Asistencia Acumulada Semanal
            </h5>
          </div>
          <small class="text-muted d-block mb-3">
            Qué muestra: Número de días asistidos por empleado durante el periodo y cantidad de retrasos
          </small>
          <div class="chart-container">
            <canvas id="chartAsistenciaSemanal"></canvas>
          </div>
          <div class="mt-2">
            <small class="text-muted"><i class="bi bi-info-circle me-1"></i>Barras verdes = asistencias, barras rojas = tardanzas (últimas 12 semanas)</small>
          </div>
        </div>
      </div>
    </div>

    <!-- Métrica 3: Ventas por Categoría (Últimos 6 meses) -->
    <div class="row g-4 mb-5">
      <div class="col-lg-12">
        <div class="card p-4">
          <div class="d-flex align-items-center mb-3">
            <h5 class="card-title mb-0">
              <i class="bi bi-pie-chart me-2 text-danger"></i>Ventas por Categoría (Últimos 6 meses)
            </h5>
          </div>
          <small class="text-muted d-block mb-3">
            Qué muestra: Monto vendido por categoría, por mes — permite identificar las categorías más vendidas
          </small>
          <div class="chart-container">
            <canvas id="chartVentasCategoria"></canvas>
          </div>
          <div class="mt-2">
            <small class="text-muted"><i class="bi bi-info-circle me-1"></i>Barras apiladas por mes (últimos 6 meses)</small>
          </div>
        </div>
      </div>
    </div>

  </div>
  
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    // @ts-nocheck
    const meses = ['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic'];
    
    function parseJson(id){
      const el = document.getElementById(id);
      if(!el) return [];
      const txt = el.textContent.trim();
      if(!txt.startsWith('[')) return [];
      try { return JSON.parse(txt); } catch(e){ console.error('Error parsing', id, e); return []; }
    }

    // Cargar sólo las 3 series necesarias
    const ventasDiarias30Data = parseJson('ventasDiarias30Data');
    const asistenciaSemanalData = parseJson('asistenciaSemanalData');
    const ventasPorCategoriaData = parseJson('ventasPorCategoriaData');

    // Formatea fecha ISO (YYYY-MM-DD) a DD/MM y a texto completo para tooltip
    function formatoDDMM(fechaIso){
      if(!fechaIso) return '';
      const d = new Date(fechaIso);
      if(isNaN(d)) return fechaIso;
      const dd = ('0'+d.getDate()).slice(-2);
      const mm = ('0'+(d.getMonth()+1)).slice(-2);
      const yyyy = d.getFullYear();
      return { corto: dd + '/' + mm, largo: dd + '/' + mm + '/' + yyyy };
    }

    // ========== MÉTRICA 1: Ventas Diarias (Últimos 30 días) ==========
    if(ventasDiarias30Data.length===0){
      document.getElementById('chartVentasDiarias30')?.insertAdjacentHTML('beforebegin','<div class="text-center text-muted">Sin datos de ventas diarias</div>');
    } else {
      // Ordenar por fecha ascendente
      ventasDiarias30Data.sort((a,b)=> new Date(a.fecha_venta) - new Date(b.fecha_venta));
      const diasLabels = ventasDiarias30Data.map(d=> d.fecha_venta);
      const diasMontos = ventasDiarias30Data.map(d=> Number(d.total_dia || 0));

      // Calcular promedio diario (constante)
      const suma = diasMontos.reduce((a,b)=>a+b,0);
      const promedioDiario = diasMontos.length>0 ? (suma / diasMontos.length) : 0;
      const promedioLine = diasMontos.map(()=>Number(promedioDiario.toFixed(2)));

      // Etiquetas DD/MM
      const diasLabelsShort = diasLabels.map(d=> formatoDDMM(d).corto);

      const ctxVentasDiarias = document.getElementById('chartVentasDiarias30')?.getContext('2d');
      if(ctxVentasDiarias) {
        new Chart(ctxVentasDiarias, {
          type:'bar',
          data:{
            labels: diasLabelsShort,
            datasets:[
              { label:'Ventas por Día (S/)', data: diasMontos, backgroundColor:'rgba(76, 175, 80, 0.8)', borderColor:'#4CAF50', borderWidth:1, borderRadius:4, yAxisID:'y' },
              { label:'Promedio de ventas por día', data: promedioLine, type:'line', borderColor:'#FF9800', borderWidth:2, pointRadius:2, tension:0.1, fill:false }
            ]
          },
          options:{
            responsive:true, maintainAspectRatio:false,
            plugins:{
              legend:{position:'top'},
              tooltip:{
                callbacks:{
                  label:function(ctx){
                    const v = ctx.parsed.y || 0;
                    return ctx.dataset.label + ': S/ ' + Number(v).toLocaleString();
                  },
                  title:function(items){
                    const idx = items[0].dataIndex;
                    const fecha = diasLabels[idx];
                    return formatoDDMM(fecha).largo;
                  }
                }
              }
            },
            scales:{
              x:{ ticks:{maxRotation:45, minRotation:0, autoSkip:true, maxTicksLimit:15} },
              y:{beginAtZero:true, ticks:{callback:(v)=>'S/ '+v}}
            }
          }
        });
      }
    }

    // ========== MÉTRICA 2: Asistencia Acumulada Semanal (por empleado, últimas 12 semanas) ==========
    if(asistenciaSemanalData.length===0){
      document.getElementById('chartAsistenciaSemanal')?.insertAdjacentHTML('beforebegin','<div class="text-center text-muted">Sin datos de asistencia semanal</div>');
    } else {
      // Agregar por empleado acumulado en el período (últimas 12 semanas)
      const ahora = new Date();
      const empleadosMap = {}; // nombre -> { asistencias, tardanzas }
      asistenciaSemanalData.forEach(d=>{
        const nombre = d.nombre_empleado || 'Sin nombre';
        if(!empleadosMap[nombre]) empleadosMap[nombre] = { asistencias:0, tardanzas:0 };
        empleadosMap[nombre].asistencias += Number(d.total_asistencias || 0);
        empleadosMap[nombre].tardanzas += Number(d.llegadas_tarde || 0);
      });

      const empleados = Object.keys(empleadosMap);
      const asistencias = empleados.map(e=>empleadosMap[e].asistencias);
      const tardanzas = empleados.map(e=>empleadosMap[e].tardanzas);

      const ctxAsistenciaSemanal = document.getElementById('chartAsistenciaSemanal')?.getContext('2d');
      if(ctxAsistenciaSemanal && empleados.length>0) {
        new Chart(ctxAsistenciaSemanal, {
          type:'bar',
          data:{
            labels: empleados,
            datasets:[
              { label:'Asistencias (últimas 12s)', data: asistencias, backgroundColor:'rgba(40,167,69,0.9)', borderColor:'#2e7d32', borderWidth:1 },
              { label:'Tardanzas (últimas 12s)', data: tardanzas, backgroundColor:'rgba(220,53,69,0.9)', borderColor:'#b71c1c', borderWidth:1 }
            ]
          },
          options:{
            responsive:true, maintainAspectRatio:false,
            plugins:{ legend:{position:'top'}, tooltip:{callbacks:{label:(ctx)=> ctx.dataset.label+': '+(ctx.parsed.y||0) }} },
            scales:{ x:{ ticks:{autoSkip:true, maxRotation:45, minRotation:0} }, y:{beginAtZero:true} }
          }
        });
      }
    }

    // ========== MÉTRICA 3: Ventas por Categoría (Últimos 6 meses) - barras apiladas ==========
    if(ventasPorCategoriaData.length===0){
      document.getElementById('chartVentasCategoria')?.insertAdjacentHTML('beforebegin','<div class="text-center text-muted">Sin datos de ventas por categoría</div>');
    } else {
      // Organizar por mes y categoría
      const mesesUnicos = [...new Set(ventasPorCategoriaData.map(d=>`${d.mes}/${d.anio}`))].slice(0,6);
      // ordenar cronológicamente (mes/anio asc)
      mesesUnicos.sort((a,b)=>{ const [ma,aa] = a.split('/').map(Number); const [mb,ab] = b.split('/').map(Number); return (aa===ab)? ma-mb : aa-ab; });

      const categorias = [...new Set(ventasPorCategoriaData.map(d=>d.nombre_categoria))];
      const colorPalette = ['#FF6384','#36A2EB','#FFCE56','#4BC0C0','#9966FF','#FF9F40','#8BC34A','#607D8B'];

      const datasets = categorias.map((cat,idx)=>{
        const data = mesesUnicos.map(m=>{
          const found = ventasPorCategoriaData.find(x=>(`${x.mes}/${x.anio}`)===m && x.nombre_categoria===cat);
          return found ? Number(found.total_ventas || 0) : 0;
        });
        const color = colorPalette[idx % colorPalette.length];
        return { label: cat, data: data, backgroundColor: color, borderColor: color, borderWidth:1 };
      });

      const mesesLabels = mesesUnicos.map(m=>{ const parts = m.split('/'); return meses[Number(parts[0])-1]+' '+parts[1]; });
      const ctxVentasCategoria = document.getElementById('chartVentasCategoria')?.getContext('2d');
      if(ctxVentasCategoria && datasets.length>0) {
        new Chart(ctxVentasCategoria, {
          type:'bar',
          data:{ labels: mesesLabels, datasets: datasets },
          options:{
            responsive:true, maintainAspectRatio:false,
            plugins:{ legend:{position:'top'}, tooltip:{callbacks:{label:(ctx)=>ctx.dataset.label+': S/ '+ctx.parsed.y.toLocaleString()}} },
            scales:{ x:{ stacked:true }, y:{ stacked:true, beginAtZero:true, ticks:{callback:(v)=>'S/ '+v} } }
          }
        });
      }
    }
  </script>
</body>
</html>
