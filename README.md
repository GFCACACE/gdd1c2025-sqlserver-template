# Sistema de Gestión de Datos

Este repositorio contiene la configuración necesaria para desplegar un servidor SQL Server con un esquema de base de datos predefinido.

## Requisitos Previos

- Docker Desktop instalado en tu sistema
- Docker Compose (viene incluido con Docker Desktop)
- Mínimo 4GB de RAM disponible
- 10GB de espacio en disco

## Instalación

1. Clona este repositorio:
```bash
git clone [URL_DEL_REPOSITORIO]
cd [NOMBRE_DEL_DIRECTORIO]
```

2. Descarga el archivo RAR del repositorio de la cátedra desde [este enlace](https://drive.google.com/file/d/14lcyAovJpGAwrDi96xL6Z1pL7utb3iix/view?usp=drive_link) y mueve los archivos .sql a la carpeta `scripts/`.

3. Asegúrate de que Docker Desktop esté en ejecución

4. Inicia los contenedores:
```bash
docker-compose up -d
```

5. Espera unos minutos a que la inicialización de la base de datos se complete. Puedes verificar el estado con:
```bash
docker-compose logs -f init-db
```

## Configuración de Acceso Remoto

Para permitir que otras IPs se conecten al servidor SQL Server, necesitas modificar el archivo `docker-compose.yml`. Por defecto, el servidor está configurado para aceptar conexiones solo desde localhost.

Para habilitar conexiones remotas:

1. Modifica el archivo `docker-compose.yml` y agrega la siguiente configuración al servicio `sqlserver`:

```yaml
services:
  sqlserver:
    # ... configuración existente ...
    environment:
      - ACCEPT_EULA=Y
      - SA_PASSWORD=YourStrong@Passw0rd
      - MSSQL_PID=Express
      - MSSQL_DATABASE=GD2C2024
      - MSSQL_TCP_PORT=1433
      - MSSQL_IP_ADDRESS=0.0.0.0
```

2. Reinicia los contenedores:
```bash
docker-compose down
docker-compose up -d
```

3. Para conectarte desde una IP remota, usa la siguiente cadena de conexión:
```
Server=IP_DEL_SERVIDOR,1433;Database=GD2C2024;User Id=sa;Password=YourStrong@Passw0rd;TrustServerCertificate=True;
```

## Notas de Seguridad

- Por defecto, la contraseña del usuario SA es `YourStrong@Passw0rd`. Se recomienda cambiarla en un entorno de producción.
- Asegúrate de configurar el firewall de tu sistema para permitir conexiones al puerto 1433 si planeas permitir acceso remoto.
- En un entorno de producción, considera implementar reglas de firewall más restrictivas y autenticación adicional.

## Solución de Problemas

Si encuentras problemas de conexión:

1. Verifica que Docker Desktop esté en ejecución
2. Asegúrate de que el puerto 1433 no esté siendo usado por otra aplicación
3. Revisa los logs de los contenedores:
```bash
docker-compose logs sqlserver
docker-compose logs init-db
```

## Estructura del Proyecto

- `docker-compose.yml`: Configuración de los contenedores Docker
- `scripts/`: Directorio que contiene los scripts SQL para la inicialización de la base de datos 