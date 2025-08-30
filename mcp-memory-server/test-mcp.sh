#!/bin/bash

# 🧠 TEST MCP MEMORY SERVER
# Script para probar el servidor MCP de memoria persistente

echo "🧠 TESTING PERITO FORENSE MCP MEMORY SERVER"
echo "==========================================="
echo ""

# Verificar que el servidor esté compilado
if [ ! -f "dist/simple-index.js" ]; then
    echo "❌ Servidor no compilado. Ejecutando build..."
    npm run build
    
    if [ $? -ne 0 ]; then
        echo "❌ Error al compilar el servidor"
        exit 1
    fi
fi

echo "✅ Servidor compilado correctamente"
echo ""

echo "🔍 Verificando estructura de archivos..."
ls -la dist/
echo ""

echo "📁 Verificando directorio de memoria..."
if [ -d "../.mcp-memory" ]; then
    echo "✅ Directorio .mcp-memory existe"
    ls -la ../.mcp-memory/
else
    echo "📂 Directorio .mcp-memory se creará al iniciar servidor"
fi
echo ""

echo "🚀 CONFIGURACIÓN PARA VS CODE:"
echo "==============================="
echo "Añadir al settings.json:"
echo ""
echo '{'
echo '  "mcp.servers": {'
echo '    "perito-forense-memory": {'
echo '      "command": "node",'
echo "      \"args\": [\"$(pwd)/dist/simple-index.js\"],"
echo '      "env": {}'
echo '    }'
echo '  }'
echo '}'
echo ""

echo "🎯 CONFIGURACIÓN PARA CLAUDE DESKTOP:"
echo "======================================="
echo "Añadir al archivo de configuración:"
echo ""
echo '{'
echo '  "mcpServers": {'
echo '    "perito-forense-memory": {'
echo '      "command": "node",'
echo "      \"args\": [\"$(pwd)/dist/simple-index.js\"]"
echo '    }'
echo '  }'
echo '}'
echo ""

echo "✅ MCP MEMORY SERVER LISTO PARA USAR"
echo "====================================="
echo ""
echo "🔧 Para probar manualmente:"
echo "node dist/simple-index.js"
echo ""
echo "📚 Ver README.md para instrucciones completas"
echo "🧠 ¡Tu proyecto ahora tiene memoria persistente!"
