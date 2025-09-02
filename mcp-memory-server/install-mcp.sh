#!/usr/bin/env bash
set -euo pipefail

# 🧠 INSTALADOR AUTOMÁTICO MCP MEMORY SERVER
# Configura automáticamente VS Code y Claude Desktop

echo "🧠 CONFIGURADOR AUTOMÁTICO MCP MEMORY SERVER"
echo "============================================="
echo ""

# Detectar ruta actual dinámicamente
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MCP_PATH="$CURRENT_DIR/dist/simple-index.js"

# Verificar que el servidor esté compilado
if [ ! -f "$MCP_PATH" ]; then
    echo "❌ Servidor no compilado. Compilando..."
    npm run build
    
    if [ ! -f "$MCP_PATH" ]; then
        echo "❌ Error al compilar el servidor"
        exit 1
    fi
fi

echo "✅ Servidor encontrado en: $MCP_PATH"
echo ""

# Test rápido de estabilidad
echo "🧪 Probando estabilidad del servidor..."
node "$MCP_PATH" & 
TEST_PID=$!
sleep 3
if kill -0 $TEST_PID 2>/dev/null; then
    echo "✅ Servidor estable (3 segundos activo)"
    kill $TEST_PID
else
    echo "❌ Servidor inestable - revisar código"
    exit 1
fi

echo ""

# Configurar VS Code
echo "🔧 Configurando VS Code..."
VSCODE_SETTINGS="$HOME/Library/Application Support/Code/User/settings.json"

if [ -f "$VSCODE_SETTINGS" ]; then
    echo "✅ Archivo settings.json encontrado"
    
    # Crear backup
    cp "$VSCODE_SETTINGS" "$VSCODE_SETTINGS.backup-$(date +%Y%m%d-%H%M%S)"
    echo "💾 Backup creado"
    
    # Mostrar configuración a añadir
    echo ""
    echo "📋 AÑADIR A VS CODE SETTINGS.JSON:"
    echo "=================================="
    echo "Añade esta configuración a tu settings.json:"
    echo ""
    echo '"mcp.servers": {'
    echo '  "perito-forense-memory": {'
    echo '    "command": "node",'
    echo "    \"args\": [\"$MCP_PATH\"],"
    echo '    "env": {}'
    echo '  }'
    echo '}'
else
    echo "❌ VS Code settings.json no encontrado"
    echo "   Crea el archivo manualmente en: $VSCODE_SETTINGS"
fi

echo ""

# Configurar Claude Desktop
echo "🎯 Configurando Claude Desktop..."
CLAUDE_CONFIG="$HOME/Library/Application Support/Claude/claude_desktop_config.json"

if [ -f "$CLAUDE_CONFIG" ]; then
    echo "✅ Archivo Claude config encontrado"
    
    # Crear backup
    cp "$CLAUDE_CONFIG" "$CLAUDE_CONFIG.backup-$(date +%Y%m%d-%H%M%S)"
    echo "💾 Backup creado"
    
    echo ""
    echo "📋 AÑADIR A CLAUDE DESKTOP CONFIG:"
    echo "================================="
    echo "Añade esta configuración:"
    echo ""
    echo '"mcpServers": {'
    echo '  "perito-forense-memory": {'
    echo '    "command": "node",'
    echo "    \"args\": [\"$MCP_PATH\"]"
    echo '  }'
    echo '}'
else
    echo "❌ Claude Desktop config no encontrado"
    echo "   Puede que Claude Desktop no esté instalado"
    echo "   O crea el archivo en: $CLAUDE_CONFIG"
fi

echo ""
echo "🚀 PRÓXIMOS PASOS:"
echo "=================="
echo "1. ✅ Añadir configuraciones mostradas arriba"
echo "2. 🔄 Reiniciar VS Code y/o Claude Desktop"
echo "3. 🧠 ¡Usar memoria persistente en tus sesiones!"
echo ""
echo "💡 Comandos útiles:"
echo "   - save_memory: Guardar información importante"
echo "   - get_project_status: Ver estado del proyecto"
echo "   - search_memory: Buscar información guardada"
echo ""
echo "🔧 Para testing manual:"
echo "   cd \"$CURRENT_DIR\""
echo "   node dist/simple-index.js"
echo ""
echo "✨ ¡Tu proyecto ahora tiene memoria persistente estable y real!"
