# 🏆 Tienda Deportiva – Registro de Ventas y Asistencia

Aplicación de gestión para una tienda deportiva construida con **Spring Boot 3.3.0**, **JSP/JSTL**, **JdbcTemplate** y **H2** en memoria. Incluye registro de ventas simplificado, panel de métricas temporales y marcación de asistencia para vendedores.

## 📋 Características Principales

### Administrador
- Gestión de empleados (activación / edición; sin eliminación física del admin principal)
- Gestión de productos y categorías (inactivación en lugar de borrado definitivo)
- Visualización de ventas y detalles
- Control de asistencia global
- Panel de métricas: Ventas mensuales, Ticket promedio mensual, Asistencia mensual (% y llegadas tarde)
- Datos semilla autocontenidos para ambiente de desarrollo (H2)

### Vendedor
- Punto de venta (carrito y confirmación de venta)
- Catálogo segmentado por categoría
- Registro de asistencia (entrada / salida)
- Historial de ventas propias
- Perfil básico de usuario


## 🛠️ Tecnologías

| Tecnología | Versión | Uso |
|------------|---------|-----|
| Java | 17 | Lenguaje principal |
| Spring Boot | 3.3.0 | Backend / configuración rápida |
| JdbcTemplate | 3.3.0 | Acceso a datos directo (SQL) |
| H2 | In-memory | Base de datos volátil para dev |
| JSP + JSTL | Jakarta EE 9+ | Capa de vista |
| Bootstrap | 5.3.x | Estilos y layout responsive |
| Chart.js | 4.4.x | Visualización de métricas |
| Maven | - | Build y dependencias |

## 📁 Estructura

```
src/main/java/com/tienda_deportiva/
  controller/   # Controladores MVC
  service/      # Lógica de negocio
  repository/   # Acceso a datos (JdbcTemplate)
  model/        # Entidades simples
src/main/resources/
  application.properties
  schema.sql    # Definición tablas
  data.sql      # Datos semilla
  static/       # CSS / imágenes
src/main/webapp/WEB-INF/views/
  admin/        # Vistas administrador
  vendedor/     # Vistas vendedor
pom.xml
```

## 🚀 Ejecución Rápida

Prerequisitos: `JDK 17`, `Maven 3.8+`

```bash
git clone https://github.com/Cristianx31/tienda-deportiva.git
cd tienda-deportiva
mvn clean spring-boot:run
```

Accesos:
- App: http://localhost:8081
- Consola H2: http://localhost:8081/h2-console  
  JDBC URL: `jdbc:h2:mem:tienda_deportiva` | Usuario: `sa` | Contraseña: (vacío)

## 👥 Usuarios Semilla

| Usuario | Contraseña | Rol |
|---------|------------|-----|
| admin   | admin      | Administrador |
| cristian| criss      | Vendedor |

> Nota: Las contraseñas están en texto plano porque es un entorno educativo. Para producción se debe aplicar hashing (BCrypt) y políticas de seguridad.

## 📊 Métricas Implementadas

corregir

## 🔄 Endpoints Destacados

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| GET | /admin/gestion | Panel principal admin |
| GET | /admin/metricas | Dashboard de métricas |
| POST | /admin/empleado-crear | Crear empleado |
| GET | /vendedor/catalogo | Catálogo productos |
| POST | /vendedor/venta/confirmar | Registrar venta |
| POST | /vendedor/marcar-entrada | Marcar asistencia entrada |
| POST | /vendedor/marcar-salida | Marcar asistencia salida |

## 🧪 Notas de Desarrollo
- Base se reinicia en cada arranque (datos efímeros)
- Scripts SQL se ejecutan siempre (`spring.sql.init.mode=always`)
- Sin ORM (No Hibernate) para mayor control y claridad académica

## 👨‍💻 Autor
**Cristian** – [Cristianx31](https://github.com/Cristianx31)

---
**Versión:** 1.1.0 | **Última actualización:** Noviembre 2025
