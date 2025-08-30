#!/bin/bash

# 🧠 AUTO-START MCP MEMORY SERVER
# Script para iniciar automáticamente el servidor MCP

echo "🧠 Iniciando MCP Memory Server..."

# Verificar que el servidor esté compilado
if [ ! -f "mcp-memory-server/dist/simple-index.js" ]; then
    echo "❌ Servidor MCP no compilado. Compilando..."
    cd mcp-memory-server
    npm run build
    cd ..
    
    if [ ! -f "mcp-memory-server/dist/simple-index.js" ]; then
        echo "❌ Error al compilar MCP server"
        exit 1
    fi
fi

echo "✅ MCP Memory Server compilado"

# Función para iniciar MCP en background
start_mcp() {
    echo "🚀 Iniciando MCP Memory Server en background..."
    nohup node mcp-memory-server/dist/simple-index.js > .mcp-server.log 2>&1 &
    MCP_PID=$!
    echo "$MCP_PID" > .mcp-server.pid
    echo "✅ MCP Server iniciado con PID: $MCP_PID"
    
    # Dar tiempo para que se inicie y verificar los logs
    sleep 2
    
    # Verificar que el log muestra que se inició correctamente
    if grep -q "Perito Forense Memory MCP Server iniciado" .mcp-server.log; then
        echo "✅ MCP Memory Server funcionando correctamente"
        echo "🧠 Memoria persistente disponible para AI assistants"
        echo "📝 Logs en: .mcp-server.log"
        return 0
    else
        echo "❌ MCP Memory Server no se inició correctamente"
        echo "📝 Ver logs en: .mcp-server.log"
        if [ -f .mcp-server.pid ]; then
            rm -f .mcp-server.pid
        fi
        return 1
    fi
}

# Si ya está corriendo
if [ -f .mcp-server.pid ]; then
    EXISTING_PID=$(cat .mcp-server.pid)
    if ps -p $EXISTING_PID > /dev/null 2>&1; then
        echo "✅ MCP Memory Server ya está funcionando (PID: $EXISTING_PID)"
        echo "🧠 Memoria persistente activa"
        exit 0
    else
        echo "🔄 Limpiando PID obsoleto..."
        rm -f .mcp-server.pid
    fi
fi

# Iniciar MCP server
start_mcp

echo ""
echo "🎯 INFORMACIÓN:"
echo "==============="
echo "• MCP Server: ✅ Corriendo"
echo "• Puerto: Protocolo Stdio"
echo "• Memoria: .mcp-memory/context.json"
echo "• Logs: Ver terminal para errores"
echo ""
if [ -f .mcp-server.pid ]; then
    CURRENT_PID=$(cat .mcp-server.pid)
    echo "💡 Para detener: kill $CURRENT_PID"
else
    echo "💡 Para detener: ./stop-mcp.sh"
fi
echo "🔧 Para reiniciar: ./auto-start-mcp.sh"
