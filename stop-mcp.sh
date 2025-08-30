#!/bin/bash

# 🛑 STOP MCP MEMORY SERVER
# Script para detener el servidor MCP

echo "🛑 Deteniendo MCP Memory Server..."

if [ -f ".mcp-server.pid" ]; then
    MCP_PID=$(cat .mcp-server.pid)
    
    if ps -p $MCP_PID > /dev/null; then
        echo "🔄 Deteniendo proceso MCP (PID: $MCP_PID)..."
        kill $MCP_PID
        
        # Esperar a que termine
        sleep 2
        
        if ps -p $MCP_PID > /dev/null; then
            echo "⚠️  Forzando detención..."
            kill -9 $MCP_PID
        fi
        
        echo "✅ MCP Memory Server detenido"
    else
        echo "❌ MCP Memory Server no estaba corriendo"
    fi
    
    rm -f .mcp-server.pid
    echo "🧹 Archivo PID limpiado"
else
    echo "❌ No se encontró archivo PID del MCP server"
fi

echo ""
echo "✅ Proceso de detención completado"
