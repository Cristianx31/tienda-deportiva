# Tienda Deportiva

Proyecto de gestión de tienda deportiva desarrollado con Spring Boot y H2 (JDBC/JdbcTemplate).

## Descripción

Esta aplicación permite administrar productos, clientes, ventas y usuarios de una tienda deportiva. El sistema utiliza H2 en memoria y acceso a datos con JDBC/JdbcTemplate.

## Requisitos

- Java 17 o superior
- Maven

## Instalación y ejecución

1. Clona este repositorio:
   ```
   git clone git clone https://github.com/Cristianx31/tienda-deportiva.git
   ```
2. Ejecuta el proyecto con Maven:
   ```
   mvn spring-boot:run
   ```
3. Accede a la aplicación en [http://localhost:8081](http://localhost:8081)

## Acceso a la base de datos H2

- Accede a la consola H2 en [http://localhost:8081/h2-console](http://localhost:8081/h2-console)
- Usa estos datos para conectar:
  - **JDBC URL:** `jdbc:h2:mem:tienda_deportiva`
  - **Usuario:** `sa`
  - **Contraseña:** *(deja vacío)*

## Estructura del proyecto

- `model/`: Clases de dominio (POJO)
- `repository/`: Acceso a datos con JdbcTemplate
- `controller/`: Controladores REST
- `service/`: Lógica de negocio
- `resources/static/`: Recursos estáticos (CSS, JS, imágenes)
- `webapp/WEB-INF/views/`: Vistas JSP
- `application.properties`: Configuración

## Colaboración

1. Haz un fork del repositorio y crea tu propia rama para trabajar.
2. Realiza tus cambios y crea un pull request para revisión.
3. Usa issues para reportar problemas o sugerir mejoras.

## Créditos

Desarrollado por el equipo de Tienda Deportiva.

---