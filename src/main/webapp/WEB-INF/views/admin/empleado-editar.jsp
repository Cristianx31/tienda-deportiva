<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Editar Empleado - DeportesX</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>
  <div class="container my-5">
    <div class="card shadow-lg">
      <div class="card-header text-center">
        <h3><i class="bi bi-pencil"></i> Editar Empleado</h3>
      </div>
      <form class="p-4" action="${pageContext.request.contextPath}/admin/empleado-editar" method="post">
        <input type="hidden" name="id_usuario" value="${empleado.id_usuario}" />
        <div class="mb-3">
          <label for="dniEmpleado" class="form-label">DNI</label>
          <input type="text" class="form-control" id="dniEmpleado" name="dni" placeholder="Ej. 12345678" value="${empleado.dni}" maxlength="8" pattern="\d{8}" inputmode="numeric" required>
        </div>
        <div class="mb-3">
          <label for="nombreEmpleado" class="form-label">Nombre Completo</label>
          <input type="text" class="form-control" id="nombreEmpleado" name="nombre_completo" placeholder="Nombre Completo" value="${empleado.nombre_completo}">
        </div>
        <div class="mb-3">
          <label for="cargoEmpleado" class="form-label">Cargo</label>
          <select class="form-select" id="cargoEmpleado" name="cargo">
            <option value="Vendedor" ${empleado.cargo == 'Vendedor' ? 'selected' : ''}>Vendedor</option>
            <option value="Administrador" ${empleado.cargo == 'Administrador' ? 'selected' : ''}>Administrador</option>
          </select>
        </div>
        <div class="mb-3">
          <label for="correoEmpleado" class="form-label">Correo</label>
          <input type="email" class="form-control" id="correoEmpleado" name="correo" placeholder="Correo" value="${empleado.correo}">
        </div>
        <div class="mb-3">
          <label for="usuarioEmpleado" class="form-label">Usuario</label>
          <input type="text" class="form-control" id="usuarioEmpleado" name="usuario" placeholder="Usuario" value="${empleado.usuario}">
        </div>
        <div class="mb-3">
          <label for="passwordEmpleado" class="form-label">Contraseña</label>
          <input type="password" class="form-control" id="passwordEmpleado" name="contrasena" placeholder="Contraseña" value="${empleado.contrasena}">
        </div>
        <div class="mb-3">
          <label for="estadoEmpleado" class="form-label">Estado</label>
          <select class="form-select" id="estadoEmpleado" name="estado">
            <option value="true" ${empleado.estado ? 'selected' : ''}>Activo</option>
            <option value="false" ${!empleado.estado ? 'selected' : ''}>Inactivo</option>
          </select>
        </div>
        <div class="row">
          <div class="col-md-6">
            <div class="mb-3">
              <label for="horaEntradaEmpleado" class="form-label">Hora de Entrada</label>
              <input type="time" class="form-control" id="horaEntradaEmpleado" name="hora_entrada" value="${empleado.hora_entrada}" required>
            </div>
          </div>
          <div class="col-md-6">
            <div class="mb-3">
              <label for="horaSalidaEmpleado" class="form-label">Hora de Salida</label>
              <input type="time" class="form-control" id="horaSalidaEmpleado" name="hora_salida" value="${empleado.hora_salida}" required>
            </div>
          </div>
        </div>
        <div class="d-flex justify-content-between">
          <a href="${pageContext.request.contextPath}/admin/gestion?tab=empleados" class="btn btn-secondary">Cancelar</a>
          <button type="submit" class="btn btn-success">Guardar Cambios</button>
        </div>
      </form>
    </div>
  </div>
</body>
</html>