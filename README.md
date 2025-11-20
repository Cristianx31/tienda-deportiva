# 🏆 Tienda Deportiva - Sistema Registro de Venta + Marcación de asistencia

Sistema de gestión completo para tienda deportiva desarrollado con **Spring Boot 3.3.0** y **JSP**.

## 📋 Características

### Módulo Administrador
- ✅ Gestión de empleados (CRUD completo)
- ✅ Gestión de productos y categorías
- ✅ Control de asistencias de vendedores
- ✅ Visualización de ventas
- ✅ Panel de métricas con gráficos (Chart.js)
- ✅ Control de inventario crítico

### Módulo Vendedor
- ✅ Sistema de punto de venta (POS)
- ✅ Catálogo de productos
- ✅ Registro de asistencias (entrada/salida)
- ✅ Historial de ventas personales
- ✅ Perfil de usuario

## 🛠️ Tecnologías

| Tecnología | Versión | Propósito |
|------------|---------|-----------|
| Java | 17 | Lenguaje principal |
| Spring Boot | 3.3.0 | Framework backend |
| JdbcTemplate | 3.3.0 | Acceso a base de datos |
| H2 Database | - | Base de datos en memoria |
| JSP + JSTL | Jakarta EE 9+ | Vistas dinámicas |
| Bootstrap | 5.3.0 | UI responsive |
| Chart.js | 4.4.0 | Gráficos interactivos |
| Maven | - | Gestión de dependencias |

## 📁 Estructura del Proyecto

```
tienda-deportiva/
├── src/main/
│   ├── java/com/tienda_deportiva/
│   │   ├── controller/          # Controladores MVC
│   │   ├── service/             # Lógica de negocio
│   │   ├── repository/          # Acceso a datos (JDBC)
│   │   └── model/               # Entidades de dominio
│   ├── resources/
│   │   ├── application.properties
│   │   ├── schema.sql          # DDL (CREATE TABLE)
│   │   ├── data.sql            # DML (INSERT)
│   │   └── static/             # CSS, imágenes
│   └── webapp/WEB-INF/views/   # Vistas JSP
│       ├── admin/
│       └── vendedor/
└── pom.xml                      # Configuración Maven
```

## 🚀 Instalación y Ejecución

### Prerrequisitos
- JDK 17 o superior
- Maven 3.6+

### Pasos

1. **Clonar el repositorio**
```bash
git clone https://github.com/Cristianx31/tienda-deportiva.git
cd tienda-deportiva
```

2. **Compilar el proyecto**
```bash
mvn clean install
```

3. **Ejecutar la aplicación**
```bash
mvn spring-boot:run
```

4. **Acceder a la aplicación**
- URL: `http://localhost:8081`
- Consola H2: `http://localhost:8081/h2-console`
  - JDBC URL: `jdbc:h2:mem:tienda_deportiva`
  - Usuario: `sa`
  - Contraseña: (vacío)

## 👥 Usuarios de Prueba

| Usuario | Contraseña | Rol |
|---------|-----------|-----|
| admin | admin123 | Administrador |
| maria.gonzalez | maria123 | Vendedor |
| carlos.lopez | carlos123 | Vendedor |

## 📊 Base de Datos

### Tablas principales
- `usuario` - Empleados del sistema
- `producto` - Catálogo de productos
- `categoria` - Categorías de productos
- `venta` - Registro de ventas
- `detalle_venta` - Items de cada venta
- `asistencia` - Control de asistencias

## 📈 Panel de Métricas

1. **Métricas Generales**: Ventas, ingresos, productos, empleados
2. **Ventas Mensuales**: Gráfico con meta (S/ 2,000)
3. **Top Categorías**: 5 más vendidas
4. **Asistencia**: Comparación mensual
5. **Inventario Crítico**: Stock < 5

## 🔄 Endpoints Principales

### Admin
- `GET /admin/gestion` - Panel principal
- `GET /admin/metricas` - Dashboard de métricas
- `POST /admin/empleado-crear` - Crear empleado

### Vendedor
- `GET /vendedor/catalogo` - Catálogo de productos
- `POST /vendedor/procesar-venta` - Procesar venta
- `POST /vendedor/marcar-entrada` - Registrar entrada

## 📖 Documentación Adicional

- [METRICAS_DOCUMENTACION.md](METRICAS_DOCUMENTACION.md) - Documentación técnica
- [METRICAS_DOCUMENTACION.html](METRICAS_DOCUMENTACION.html) - Versión HTML

## 👨‍💻 Autor

**Cristian** - [Cristianx31](https://github.com/Cristianx31)

---

**Versión:** 1.0.0 | **Última actualización:** Noviembre 2025
