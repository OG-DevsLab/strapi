#!/bin/bash

# =============================================================#
# Script para verificar el estado del build y levantar Strapi
# =============================================================#

echo "🔍 Verificando estado del build..."

# Verificar si la imagen está construída
if docker images | grep -q "strapi.*latest\|strapi.*strapi"; then
    echo "✅ Imagen encontrada!"

    echo "🚀 Iniciando Strapi..."
    docker compose -f docker-compose.full.yml up strapi -d

    echo "⏳ Esperando que Strapi esté listo..."
    sleep 15

    echo "✅ ¡Strapi iniciado!"
    echo ""
    echo "📱 URLs disponibles:"
    echo "   • Strapi Admin: http://localhost:1337/admin"
    echo "   • Strapi API: http://localhost:1337"
    echo ""
    echo "📋 Comandos útiles:"
    echo "   • Ver logs: docker compose -f docker-compose.full.yml logs -f strapi"
    echo "   • Detener: docker compose -f docker-compose.full.yml down"
    echo ""

    # Verificar si el contenedor está corriendo
    if docker ps | grep -q strapi; then
        echo "🟢 Estado: Strapi está corriendo"
        docker compose -f docker-compose.full.yml logs --tail=10 strapi
    else
        echo "🔴 Estado: Strapi no está corriendo"
        echo "📋 Ver logs con: docker compose -f docker-compose.full.yml logs strapi"
    fi

else
    echo "⏳ Build aún en progreso..."
    echo "📋 Ver progreso: docker compose -f docker-compose.full.yml build"
fi