#!/bin/bash

# 🧠 MCP Global Command - Ejecutar desde cualquier proyecto
# Uso: mcp [start|stop|status|install]

MCP_DETECTOR="/Users/manuelfernandezdelreal/MCP/auto-mcp-detector.sh"

case "${1:-auto}" in
    "auto"|"")
        # Auto-detección e instalación
        "$MCP_DETECTOR"
        ;;
    "start")
        if [[ -f "auto-start-mcp.sh" ]]; then
            ./auto-start-mcp.sh
        else
            echo "🔍 MCP no encontrado, auto-instalando..."
            "$MCP_DETECTOR"
        fi
        ;;
    "stop")
        if [[ -f "stop-mcp.sh" ]]; then
            ./stop-mcp.sh
        else
            echo "❌ MCP no instalado en este proyecto"
        fi
        ;;
    "status")
        if [[ -f ".mcp-server.pid" ]]; then
            PID=$(cat .mcp-server.pid)
            if ps -p $PID > /dev/null 2>&1; then
                echo "✅ MCP corriendo (PID: $PID)"
            else
                echo "❌ MCP no está corriendo"
            fi
        else
            echo "❌ MCP no instalado"
        fi
        ;;
    "install")
        "$MCP_DETECTOR"
        ;;
    "help"|"-h"|"--help")
        echo "🧠 MCP Global Command"
        echo ""
        echo "Uso: mcp [comando]"
        echo ""
        echo "Comandos:"
        echo "  mcp          - Auto-detección e instalación"
        echo "  mcp start    - Iniciar MCP"
        echo "  mcp stop     - Detener MCP" 
        echo "  mcp status   - Ver estado"
        echo "  mcp install  - Forzar instalación"
        echo "  mcp help     - Mostrar ayuda"
        ;;
    *)
        echo "❌ Comando desconocido: $1"
        echo "💡 Usa 'mcp help' para ver comandos disponibles"
        ;;
esac
