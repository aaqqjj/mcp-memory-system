#!/bin/bash

# 🧠 INSTALADOR AUTOMÁTICO MCP MEMORY SERVER
# Configura automáticamente VS Code y Claude Desktop

echo "🧠 CONFIGURADOR AUTOMÁTICO MCP MEMORY SERVER"
echo "============================================="
echo ""

MCP_PATH="/Users/manuelfernandezdelreal/peritoForenseMain/perito-forense-web/mcp-memory-server/dist/simple-index.js"

# Configurar VS Code
echo "🔧 Configurando VS Code..."
VSCODE_SETTINGS="$HOME/Library/Application Support/Code/User/settings.json"

if [ -f "$VSCODE_SETTINGS" ]; then
    echo "✅ Archivo settings.json encontrado"
    
    # Crear backup
    cp "$VSCODE_SETTINGS" "$VSCODE_SETTINGS.backup-$(date +%Y%m%d-%H%M%S)"
    echo "💾 Backup creado en: $VSCODE_SETTINGS.backup-$(date +%Y%m%d-%H%M%S)"
    
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
echo "✨ ¡Tu proyecto ahora tiene memoria persistente real!"
