# Strapi Development Setup Guide

Este proyecto es un fork del repositorio oficial de Strapi configurado para desarrollo local y despliegue en EKS.

## 📋 Requisitos

- **Node.js**: 18.x - 22.x
- **Yarn**: 4.5.0 (incluido en el proyecto via corepack)
- **Docker**: Para contenedores
- **Docker Compose**: Para orquestación local

## 🚀 Configuración Local

### 1. Clonar y preparar el proyecto

```bash
# Clonar el repositorio
git clone <tu-repo>
cd strapi

# Habilitar corepack para Yarn 4.5.0
corepack enable

# Instalar dependencias del monorepo
yarn install

# Construir todos los paquetes
yarn build
```

### 2. Configurar variables de entorno

```bash
# Copiar el archivo de ejemplo
cp .env.example .env

# Editar las variables según necesites
nano .env
```

### 3. Configurar base de datos

#### Opción A: PostgreSQL con Docker Compose
```bash
# Levantar solo PostgreSQL
docker-compose -f docker-compose.dev.yml up postgres -d

# Verificar que esté corriendo
docker ps
```

#### Opción B: MySQL con Docker Compose
```bash
# Levantar solo MySQL
docker-compose -f docker-compose.dev.yml up mysql -d

# Actualizar .env para usar MySQL
DATABASE_CLIENT=mysql
DATABASE_HOST=localhost
DATABASE_PORT=3306
```

### 4. Ejecutar Strapi localmente

```bash
# Ir al directorio de ejemplo
cd examples/getstarted

# Instalar driver de base de datos
yarn add pg  # Para PostgreSQL
# o
yarn add mysql2  # Para MySQL

# Ejecutar en modo desarrollo
yarn develop
```

La aplicación estará disponible en:
- **Frontend**: http://localhost:1337
- **Admin Panel**: http://localhost:1337/admin

## 🐳 Configuración con Docker

### 1. Construir la imagen

```bash
# Construir imagen Docker
docker build -t strapi-dev .
```

### 2. Ejecutar con Docker Compose completo

```bash
# Levantar toda la stack (Strapi + PostgreSQL)
docker-compose -f docker-compose.dev.yml up

# O en segundo plano
docker-compose -f docker-compose.dev.yml up -d
```

### 3. Ejecutar solo el contenedor Strapi

```bash
# Asegurate de tener la base de datos corriendo
docker-compose -f docker-compose.dev.yml up postgres -d

# Ejecutar Strapi
docker run -p 1337:1337 \
  --env-file .env \
  --name strapi-app \
  strapi-dev
```

## 🏗️ Estructura del Proyecto

```
strapi/
├── packages/          # Paquetes del monorepo Strapi
├── examples/
│   └── getstarted/    # Aplicación de ejemplo (punto de entrada)
├── k8s/              # Configuraciones Kubernetes
│   └── dev/          # Entorno de desarrollo
│       ├── strapi/   # Manifiestos de Strapi
│       └── postgress/ # Manifiestos de PostgreSQL
├── Dockerfile        # Imagen Docker para producción
├── docker-compose.dev.yml # Orquestación local
└── .env.example      # Variables de entorno
```

## ⚙️ Scripts Disponibles

```bash
# Desarrollo
yarn develop          # Modo desarrollo con recarga automática
yarn build           # Construir la aplicación
yarn start           # Ejecutar en modo producción

# Testing
yarn test:unit       # Tests unitarios
yarn test:api        # Tests de API
yarn test:e2e        # Tests end-to-end

# Linting y formato
yarn lint            # Verificar código
yarn lint:fix        # Arreglar problemas de linting
yarn format          # Formatear código
```

## 🔧 Desarrollo

### Trabajar con el monorepo

```bash
# Construir un paquete específico
yarn nx run @strapi/core:build

# Ejecutar tests de un paquete
yarn nx run @strapi/admin:test

# Ver todos los proyectos
yarn nx show projects
```

### Agregar nuevas dependencias

```bash
# En el directorio raíz (para el monorepo)
yarn add <paquete>

# En la aplicación de ejemplo
cd examples/getstarted
yarn add <paquete>
```

## 🐛 Troubleshooting

### Error de lockfile desactualizado
El Dockerfile está configurado para manejar este problema automáticamente con `yarn install` sin modo inmutable.

### Problemas de permisos con Docker
```bash
# Construir sin cache
docker build --no-cache -t strapi-dev .

# Verificar permisos del directorio
ls -la /opt/app
```

### Base de datos no conecta
```bash
# Verificar que el contenedor esté corriendo
docker ps | grep postgres

# Verificar logs
docker logs <container-id>

# Probar conexión
telnet localhost 5432
```

## 🚀 Despliegue en EKS

El proyecto incluye manifiestos de Kubernetes en `k8s/dev/`:

1. **Secretos**: Configurados en `strapi.secret.yml` y `postgress.secret.yml`
2. **StatefulSet**: Para persistencia de datos
3. **Service**: Para comunicación interna
4. **Ingress**: Para acceso externo con ALB

### Aplicar configuraciones

```bash
# Aplicar todos los manifiestos
kubectl apply -f k8s/dev/

# O uno por uno
kubectl apply -f k8s/dev/postgress/
kubectl apply -f k8s/dev/strapi/
```

## 📝 Notas importantes

- **Seguridad**: Cambia todas las claves secretas antes de producción
- **Base de datos**: Las credenciales por defecto son para desarrollo únicamente
- **Monorepo**: Este es un proyecto complejo, usa `yarn` exclusivamente
- **Docker**: La imagen está optimizada para el monorepo completo

## 🔗 Enlaces útiles

- [Documentación oficial de Strapi](https://docs.strapi.io)
- [Guías de desarrollo](https://docs.strapi.io/developer-docs)
- [API Reference](https://docs.strapi.io/developer-docs/latest/developer-resources/database-apis-reference/)

---
**Entorno**: Desarrollo | **Versión**: 4.x | **Node**: 18-22.x