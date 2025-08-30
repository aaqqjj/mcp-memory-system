#!/bin/bash

# 🧠 Auto-Save Session Script
# Este script se ejecuta automáticamente al cerrar VS Code o apagar el equipo

# Función para guardar sesión automáticamente
auto_save_session() {
    local timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
    local session_id="auto_session_$timestamp"
    
    echo "💾 Auto-guardando sesión antes de cerrar..."
    
    # Solo ejecutar si estamos en un proyecto con MCP
    if [[ -f ".mcp-installed" && -d ".mcp-memory" ]]; then
        
        # Crear script de auto-guardado rápido
        cat > .mcp-memory/auto-save.cjs << JSEOF
const fs = require('fs');

try {
    let context = {};
    if (fs.existsSync('.mcp-memory/context.json')) {
        context = JSON.parse(fs.readFileSync('.mcp-memory/context.json', 'utf8'));
    }

    const autoSaveInfo = {
        id: "$session_id",
        timestamp: "$timestamp", 
        tipo: "auto_save",
        fecha: new Date().toISOString(),
        estado: "sesion_cerrada_automaticamente",
        nota: "Guardado automático antes de cerrar proyecto"
    };

    if (!context.memory.data) context.memory.data = {};
    context.memory.data["$session_id"] = autoSaveInfo;
    
    context.memory.auto_saves = context.memory.auto_saves || [];
    context.memory.auto_saves.push({
        timestamp: "$timestamp",
        fecha: new Date().toISOString()
    });

    // Mantener solo los últimos 10 auto-saves
    if (context.memory.auto_saves.length > 10) {
        context.memory.auto_saves = context.memory.auto_saves.slice(-10);
    }

    fs.writeFileSync('.mcp-memory/context.json', JSON.stringify(context, null, 2));
    console.log('✅ Sesión auto-guardada: $session_id');
} catch (error) {
    console.log('⚠️  Auto-save falló, pero MCP seguirá funcionando');
}
JSEOF

        # Ejecutar auto-save
        node .mcp-memory/auto-save.cjs 2>/dev/null
        rm -f .mcp-memory/auto-save.cjs
        
        echo "✅ Sesión guardada automáticamente"
    fi
}

# Ejecutar función
auto_save_session
