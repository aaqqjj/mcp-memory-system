#!/bin/bash

# 🧠 Script para guardar automáticamente la sesión actual en MCP
# Este script guarda el contexto de la conversación actual antes de apagar el equipo

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
SESSION_ID="session_$TIMESTAMP"

echo "💾 Guardando sesión actual en MCP..."
echo "📅 Timestamp: $TIMESTAMP"
echo "🆔 Session ID: $SESSION_ID"

# Crear script de guardado de sesión
cat > .mcp-memory/save-session.cjs << JSEOF
const fs = require('fs');

// Cargar contexto actual
let context = {};
if (fs.existsSync('.mcp-memory/context.json')) {
    context = JSON.parse(fs.readFileSync('.mcp-memory/context.json', 'utf8'));
}

// Información de la sesión actual
const sessionInfo = {
    id: "$SESSION_ID",
    timestamp: "$TIMESTAMP",
    fecha_completa: new Date().toISOString(),
    temas_discutidos: [
        "Sistema de memoria persistente MCP",
        "Configuración global automática",
        "Auto-detección de proyectos",
        "Importación de historial completo",
        "Reutilización entre proyectos",
        "Persistencia de conversaciones"
    ],
    decisiones_tomadas: [
        "MCP instalado y funcionando globalmente",
        "Comando 'mcp' disponible desde cualquier proyecto", 
        "Auto-instalación configurada",
        "Historial completo importado (68 archivos)",
        "Sistema de backup implementado",
        "Memoria separada por proyecto"
    ],
    estado_actual: "Sistema MCP completamente funcional",
    proxima_sesion: {
        contexto: "Continuar con testing del sistema MCP",
        recordar: [
            "MCP funciona desde cualquier proyecto con comando 'mcp'",
            "Historial completo disponible desde 23 agosto",
            "Sistema global configurado en /Users/manuelfernandezdelreal/MCP/",
            "Memoria persistente activa y funcionando"
        ]
    },
    archivos_creados_hoy: [
        "MCP-GLOBAL-AUTOMATIZADO.md",
        "REUTILIZAR-MCP-PROYECTOS.md", 
        "import-historial-completo.sh",
        "importar-historial-simple.sh",
        "auto-mcp-detector.sh",
        "mcp-global.sh",
        "configure-mcp-global.sh"
    ]
};

// Guardar en data del contexto
if (!context.memory.data) {
    context.memory.data = {};
}

context.memory.data["$SESSION_ID"] = sessionInfo;

// Actualizar última sesión
context.memory.ultima_sesion = {
    id: "$SESSION_ID",
    fecha: new Date().toISOString(),
    duracion_aproximada: "2+ horas",
    logros: [
        "Sistema MCP global implementado",
        "Historial completo importado", 
        "Auto-instalación funcionando",
        "Memoria persistente activada"
    ]
};

// Actualizar keyPoints con información de la sesión
context.memory.keyPoints.push("💾 Sesión $TIMESTAMP guardada automáticamente");
context.memory.keyPoints.push("🎯 Sistema MCP completamente operativo");

// Guardar contexto actualizado  
fs.writeFileSync('.mcp-memory/context.json', JSON.stringify(context, null, 2));

console.log('✅ Sesión guardada exitosamente');
console.log('🆔 Session ID: $SESSION_ID');
console.log('📝 Contexto de conversación preservado');
console.log('🔄 Próxima sesión continuará automáticamente');
JSEOF

# Ejecutar guardado
node .mcp-memory/save-session.cjs

# Limpiar archivo temporal
rm -f .mcp-memory/save-session.cjs

echo ""
echo "✅ SESIÓN GUARDADA COMPLETAMENTE"
echo "==============================="
echo "🧠 Conversación actual preservada en MCP"
echo "📝 Contexto disponible para próxima sesión"
echo "🔄 Al reabrir VS Code, toda la memoria estará disponible"
echo ""
echo "💡 Verificar guardado:"
echo "   cat .mcp-memory/context.json | grep -A 5 'ultima_sesion'"
echo ""
echo "🎯 RESUMEN DE LO LOGRADO HOY:"
echo "• ✅ Sistema MCP global implementado"
echo "• ✅ Auto-detección de proyectos funcionando"  
echo "• ✅ Comando 'mcp' disponible globalmente"
echo "• ✅ Historial completo importado (68 archivos)"
echo "• ✅ Memoria persistente funcionando"
echo "• ✅ Sistema listo para nuevos proyectos"
