<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login - Tienda Deportiva</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body class="login-bg">

  <div class="container">
    <div class="row justify-content-center align-items-center" style="min-height: 80vh;">
      <div class="col-md-5">
        <div class="card p-4 shadow">
          <div class="text-center mb-3">
            <img src="${pageContext.request.contextPath}/assets/img/logo.png" alt="Logo DeportesX" style="width:260px; height: 100px;">
            <h3 class="mt-2 mb-1">Bienvenido</h3>
            <p class="text-muted mb-2">Inicia sesión con tu cuenta</p>
          </div>

          <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger text-center">
              <%= request.getAttribute("error") %>
            </div>
          <% } %>

          <form method="post" action="${pageContext.request.contextPath}/login">
            <!-- Usuario -->
            <div class="mb-3 input-group">
              <span class="input-group-text"><i class="bi bi-person"></i></span>
              <input type="text" class="form-control" name="usuario" placeholder="Usuario" required>
            </div>

            <!-- Contraseña -->
            <div class="mb-3 input-group">
              <span class="input-group-text"><i class="bi bi-lock"></i></span>
              <input type="password" class="form-control" name="contrasena" placeholder="Contraseña" required>
            </div>

            <!-- Solo el enlace de recuperación -->
            <div class="mb-3 text-end">
              <a href="#" class="text-decoration-none">¿Olvidaste tu contraseña?</a>
            </div>

            <!-- Botón solo para entrar -->
            <button type="submit" class="btn btn-primary w-100 mb-2">Entrar</button>
          </form>
        </div>
      </div>
    </div>
  </div>

</body>
</html>