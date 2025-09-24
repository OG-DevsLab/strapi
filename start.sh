#!/bin/bash

# =============================================================#
# Script para levantar Strapi con Docker
# =============================================================#

echo "🚀 Iniciando Strapi con Docker..."

# Verificar que existe el archivo .env
if [ ! -f .env ]; then
    echo "❌ Archivo .env no encontrado"
    echo "📝 Copiando .env.example a .env..."
    cp .env.example .env
    echo "✅ Archivo .env creado. Puedes editarlo si necesitas cambiar configuraciones."
fi

echo "🐘 Iniciando PostgreSQL..."
docker compose -f docker-compose.dev.yml up postgres -d

echo "⏳ Esperando que PostgreSQL esté listo..."
sleep 10

echo "🏗️ Construyendo imagen de Strapi (esto puede tomar varios minutos)..."
docker compose -f docker-compose.full.yml build

echo "🚀 Iniciando Strapi..."
docker compose -f docker-compose.full.yml up strapi -d

echo "✅ Servicios iniciados!"
echo ""
echo "📱 URLs disponibles:"
echo "   • Strapi Admin: http://localhost:1337/admin"
echo "   • Strapi API: http://localhost:1337"
echo ""
echo "📋 Comandos útiles:"
echo "   • Ver logs: docker compose -f docker-compose.full.yml logs -f"
echo "   • Detener: docker compose -f docker-compose.full.yml down"
echo "   • Reiniciar: docker compose -f docker-compose.full.yml restart"
echo ""
echo "🔧 Base de datos PostgreSQL:"
echo "   • Host: localhost:5432"
echo "   • DB: strapi"
echo "   • User: strapi"
echo "   • Pass: strapi"