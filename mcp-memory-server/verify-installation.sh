#!/usr/bin/env bash
set -euo pipefail

# 🔍 VERIFICADOR DE INSTALACIÓN MCP MEMORY SERVER
# Comprueba que todo esté configurado correctamente

echo "🔍 VERIFICADOR DE INSTALACIÓN MCP"
echo "================================="
echo ""

# Detectar directorio actual
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MCP_PATH="$CURRENT_DIR/dist/simple-index.js"

echo "📍 Verificando ruta del servidor..."
if [ -f "$MCP_PATH" ]; then
    echo "✅ Servidor compilado encontrado: $MCP_PATH"
else
    echo "❌ Servidor no encontrado en: $MCP_PATH"
    echo "   Ejecuta: npm run build"
    exit 1
fi

echo ""
echo "🧪 Verificando estabilidad del proceso..."

# Test de estabilidad extendido
node "$MCP_PATH" & 
TEST_PID=$!

# Verificar que el proceso esté corriendo
sleep 1
if ! kill -0 $TEST_PID 2>/dev/null; then
    echo "❌ El proceso falló inmediatamente"
    exit 1
fi

echo "⏱️  Proceso activo durante 1 segundo..."

# Verificar estabilidad durante 5 segundos
sleep 4
if kill -0 $TEST_PID 2>/dev/null; then
    echo "✅ Proceso estable durante 5 segundos"
    kill $TEST_PID 2>/dev/null || true
    wait $TEST_PID 2>/dev/null || true
else
    echo "❌ El proceso falló después de 5 segundos"
    exit 1
fi

echo ""
echo "🔧 Verificando configuraciones..."

# Verificar VS Code
VSCODE_SETTINGS="$HOME/Library/Application Support/Code/User/settings.json"
if [ -f "$VSCODE_SETTINGS" ]; then
    echo "✅ VS Code settings.json existe"
    
    if grep -q "perito-forense-memory" "$VSCODE_SETTINGS" 2>/dev/null; then
        echo "✅ Configuración MCP encontrada en VS Code"
    else
        echo "⚠️  Configuración MCP no encontrada en VS Code"
        echo "   Añade la configuración mostrada por install-mcp.sh"
    fi
else
    echo "❌ VS Code settings.json no existe"
fi

# Verificar Claude Desktop
CLAUDE_CONFIG="$HOME/Library/Application Support/Claude/claude_desktop_config.json"
if [ -f "$CLAUDE_CONFIG" ]; then
    echo "✅ Claude Desktop config existe"
    
    if grep -q "perito-forense-memory" "$CLAUDE_CONFIG" 2>/dev/null; then
        echo "✅ Configuración MCP encontrada en Claude"
    else
        echo "⚠️  Configuración MCP no encontrada en Claude"
        echo "   Añade la configuración mostrada por install-mcp.sh"
    fi
else
    echo "⚠️  Claude Desktop config no existe"
    echo "   Puede que Claude Desktop no esté instalado"
fi

echo ""
echo "🧠 Verificando dependencias..."

# Verificar Node.js
if command -v node >/dev/null 2>&1; then
    NODE_VERSION=$(node --version)
    echo "✅ Node.js disponible: $NODE_VERSION"
    
    # Verificar que sea una versión reciente
    NODE_MAJOR=$(echo "$NODE_VERSION" | sed 's/v\([0-9]*\).*/\1/')
    if [ "$NODE_MAJOR" -ge 16 ]; then
        echo "✅ Versión de Node.js compatible (>= 16)"
    else
        echo "⚠️  Versión de Node.js antigua. Recomendado >= 16"
    fi
else
    echo "❌ Node.js no encontrado"
    exit 1
fi

# Verificar npm
if command -v npm >/dev/null 2>&1; then
    NPM_VERSION=$(npm --version)
    echo "✅ npm disponible: v$NPM_VERSION"
else
    echo "❌ npm no encontrado"
    exit 1
fi

echo ""
echo "📦 Verificando módulos Node..."

if [ -d "$CURRENT_DIR/node_modules" ]; then
    echo "✅ node_modules existe"
    
    # Verificar dependencias críticas
    CRITICAL_DEPS=("@modelcontextprotocol/sdk" "typescript")
    for dep in "${CRITICAL_DEPS[@]}"; do
        if [ -d "$CURRENT_DIR/node_modules/$dep" ]; then
            echo "✅ $dep instalado"
        else
            echo "❌ $dep no encontrado"
            echo "   Ejecuta: npm install"
        fi
    done
else
    echo "❌ node_modules no existe"
    echo "   Ejecuta: npm install"
fi

echo ""
echo "🎯 RESUMEN DE VERIFICACIÓN"
echo "=========================="

# Determinar estado general
if [ -f "$MCP_PATH" ] && command -v node >/dev/null 2>&1; then
    echo "✅ **SISTEMA LISTO**: El servidor MCP está funcionalmente completo"
    echo ""
    echo "🚀 Para usar:"
    echo "   1. Reinicia VS Code/Claude Desktop si ya los tienes abiertos"
    echo "   2. La memoria persistente estará disponible automáticamente"
    echo "   3. Prueba comandos como: save_memory, get_project_status"
    echo ""
    echo "🔧 Para testing directo:"
    echo "   node \"$MCP_PATH\""
    echo ""
    echo "✨ ¡Todo listo para usar memoria persistente!"
else
    echo "❌ **SISTEMA INCOMPLETO**: Faltan componentes críticos"
    echo ""
    echo "🔧 Pasos para completar:"
    echo "   1. npm install"
    echo "   2. npm run build" 
    echo "   3. ./install-mcp.sh"
    echo "   4. ./verify-installation.sh"
fi

echo ""
