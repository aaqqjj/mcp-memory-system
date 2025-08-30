#!/bin/bash

# 🧠 Instalador de MCP Memory System
# Uso: ./install-mcp.sh [nombre-proyecto]

PROJECT_NAME=${1:-"mi-proyecto"}

echo "🚀 Instalando MCP Memory System para: $PROJECT_NAME"

# Copiar archivos
cp -r mcp-memory-server ./
cp auto-start-mcp.sh ./
cp stop-mcp.sh ./

# Crear .vscode si no existe
mkdir -p .vscode
cp -r .vscode-template/* .vscode/ 2>/dev/null || true

# Hacer scripts ejecutables
chmod +x auto-start-mcp.sh
chmod +x stop-mcp.sh

# Personalizar configuración para el nuevo proyecto
if [ -f mcp-memory-server/src/simple-index.ts ]; then
    sed -i.bak "s/perito-forense-web/$PROJECT_NAME/g" mcp-memory-server/src/simple-index.ts
fi

# Instalar dependencias
echo "📦 Instalando dependencias..."
cd mcp-memory-server
npm install
npm run build
cd ..

# Crear directorio de memoria
mkdir -p .mcp-memory

echo "✅ MCP Memory System instalado para: $PROJECT_NAME"
echo ""
echo "🎯 SIGUIENTE PASO:"
echo "./auto-start-mcp.sh"
echo ""
echo "💡 El sistema guardará automáticamente todas las conversaciones"
echo "   e iteraciones de desarrollo de tu nuevo proyecto"
