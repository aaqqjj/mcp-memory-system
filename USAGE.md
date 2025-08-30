# 📖 Guía de Uso Completa

## 🚀 Inicio Rápido

### Primer Uso
```bash
# 1. Navegar a tu proyecto
cd /path/to/your/project

# 2. Activar MCP (auto-detección e instalación)
mcp

# 3. ¡Listo! El sistema está funcionando
# ✅ Servidor MCP activo
# ✅ Memoria persistente configurada
# ✅ Auto-save activado
# ✅ VS Code integrado
```

### Verificar Estado
```bash
# Ver estado del servidor
mcp-status

# Ver logs en tiempo real
tail -f .mcp-server.log

# Ver memoria actual
cat .mcp-memory/context.json | jq .
```

## 🎯 Comandos Principales

### Comando Global `mcp`
El comando principal que lo hace todo automáticamente:

```bash
mcp                    # Auto-detecta, instala y configura MCP
```

**¿Qué hace internamente?**
1. 🔍 Detecta si es un proyecto de desarrollo
2. 📦 Instala MCP si no está presente
3. 💾 Agrega sistema de guardado automático
4. 🎛️ Configura VS Code tasks
5. 🚀 Inicia servidor MCP
6. ✅ Confirma que todo funciona

### Comandos de Guardado

#### Guardado Manual Completo
```bash
save-session           # Alias para guardado completo
./guardar-sesion-actual.sh    # Script completo
```

**¿Qué guarda?**
- 🗣️ Conversación actual completa
- 📅 Timestamp preciso
- 🎯 Temas discutidos en la sesión
- 📋 Decisiones tomadas
- 📝 Estado actual del proyecto
- 🔄 Próximos pasos identificados

#### Auto-Save Rápido
```bash
mcp-save               # Alias para auto-save
./auto-save-session.sh # Script de auto-save
```

**¿Qué guarda?**
- ⚡ Estado básico de la sesión
- 📅 Timestamp de auto-save
- 🆔 ID de sesión actual
- 📊 Estado del servidor MCP

### Comandos de Control del Servidor

#### Iniciar MCP
```bash
./auto-start-mcp.sh
```

**Proceso de inicio:**
1. 🔧 Compila código TypeScript
2. 🚀 Inicia servidor en background
3. 📝 Crea archivo PID
4. ✅ Verifica funcionamiento
5. 📋 Muestra información de estado

#### Detener MCP
```bash
./stop-mcp.sh
```

**Proceso de detención:**
1. 📋 Lee PID del servidor
2. 🛑 Termina proceso gracefully
3. 🧹 Limpia archivos temporales
4. ✅ Confirma detención

#### Reiniciar MCP
```bash
./stop-mcp.sh && ./auto-start-mcp.sh
```

## 💾 Sistema de Memoria

### Estructura de Memoria
```json
{
  "memory": {
    "data": {
      "session_YYYY-MM-DD_HH-MM-SS": {
        "temas_discutidos": ["tema1", "tema2"],
        "decisiones_tomadas": ["decision1", "decision2"],
        "proxima_sesion": {
          "recordar": ["item1", "item2"]
        }
      }
    },
    "ultima_sesion": {
      "fecha": "2025-08-30T01:39:04.940Z",
      "logros": ["logro1", "logro2"]
    },
    "historial_completo": {
      "archivos_procesados": 68,
      "timeline_principal": {...}
    }
  }
}
```

### Acceder a la Memoria

#### Ver Última Sesión
```bash
cat .mcp-memory/context.json | jq '.memory.ultima_sesion'
```

#### Ver Todas las Sesiones
```bash
cat .mcp-memory/context.json | jq '.memory.data | keys'
```

#### Buscar en Conversaciones
```bash
cat .mcp-memory/context.json | jq '.memory.data[] | select(.temas_discutidos[] | contains("MCP"))'
```

#### Exportar Memoria
```bash
# Backup completo
cp .mcp-memory/context.json backup_$(date +%Y%m%d_%H%M%S).json

# Exportar solo sesiones específicas
cat .mcp-memory/context.json | jq '.memory.data | to_entries | .[] | select(.key | contains("2025-08"))' > sesiones_agosto.json
```

## 🎛️ Integración con VS Code

### Tasks Automáticas
El sistema crea automáticamente estas tasks en `.vscode/tasks.json`:

#### Start MCP Memory Server
- **Comando**: `./auto-start-mcp.sh`
- **Cuándo**: Al abrir carpeta (`runOn: folderOpen`)
- **Función**: Inicia automáticamente el servidor MCP

#### Stop MCP Memory Server  
- **Comando**: `./stop-mcp.sh`
- **Función**: Detiene el servidor MCP manualmente

#### Auto-Save MCP Session
- **Comando**: `./auto-save-session.sh`
- **Función**: Guarda sesión actual silenciosamente

#### Dev Server + MCP
- **Comando**: `./quick-start.sh` (si existe)
- **Función**: Inicia servidor de desarrollo + MCP simultáneamente

### Ejecutar Tasks

#### Desde Command Palette
1. `Cmd+Shift+P` (macOS) o `Ctrl+Shift+P` (Windows/Linux)
2. Escribir: `Tasks: Run Task`
3. Seleccionar la task deseada

#### Desde Terminal Integrada
```bash
# Ver tasks disponibles
code --list-extensions | grep task

# Ejecutar task específica
# (Se ejecutan automáticamente al abrir VS Code)
```

### Configuración VS Code Avanzada

#### settings.json Recomendado
```json
{
  "files.associations": {
    "*.mcp": "json",
    ".mcp-*": "json"
  },
  "files.watcherExclude": {
    "**/.mcp-memory/**": true,
    "**/mcp-memory-server/node_modules/**": true
  },
  "terminal.integrated.cwd": "${workspaceFolder}",
  "task.autoDetect": "on"
}
```

## 🔄 Flujos de Trabajo Típicos

### Nuevo Proyecto
```bash
# 1. Crear o navegar al proyecto
mkdir mi-nuevo-proyecto
cd mi-nuevo-proyecto

# 2. Crear archivo de proyecto (package.json, etc.)
echo '{"name": "mi-nuevo-proyecto"}' > package.json

# 3. Activar MCP
mcp

# 4. Abrir en VS Code
code .

# ✅ MCP se inicia automáticamente
# ✅ Memoria persistente lista
# ✅ Auto-save configurado
```

### Sesión de Desarrollo Diaria
```bash
# 1. Abrir proyecto en VS Code
code /path/to/project

# 2. MCP se inicia automáticamente
# (VS Code task ejecuta auto-start-mcp.sh)

# 3. Trabajar normalmente con IA
# (Conversaciones se guardan automáticamente)

# 4. Al final del día, guardar sesión manualmente
save-session

# 5. Cerrar VS Code
# (Auto-save se ejecuta automáticamente)
```

### Cambiar Entre Proyectos
```bash
# 1. Cerrar proyecto actual
# (Auto-save automático en VS Code)

# 2. Navegar a otro proyecto
cd /path/to/other-project

# 3. Activar MCP
mcp

# 4. Abrir en VS Code
code .

# ✅ Memoria específica del proyecto cargada
# ✅ Contexto anterior preservado
# ✅ Nuevo servidor MCP iniciado
```

### Backup y Restauración
```bash
# Backup manual antes de cambios importantes
save-session
cp .mcp-memory/context.json backup_pre_refactor.json

# Restaurar desde backup si es necesario
cp backup_pre_refactor.json .mcp-memory/context.json
./stop-mcp.sh && ./auto-start-mcp.sh
```

## 🐛 Debugging y Logs

### Ver Logs en Tiempo Real
```bash
# Logs del servidor MCP
tail -f .mcp-server.log

# Logs de inicio
tail -f .mcp-start.log

# Logs de auto-save
tail -f .mcp-autosave.log
```

### Debugging del Servidor
```bash
# Verificar proceso
ps aux | grep mcp

# Verificar puerto/conexión
lsof -i :3000  # Si usas puerto específico

# Test de conexión MCP
node -e "console.log('Testing MCP connection...')"
```

### Logs Estructurados
El sistema genera logs en formato estructurado:

```json
{
  "timestamp": "2025-08-30T01:39:04.940Z",
  "level": "info",
  "message": "MCP Server started",
  "pid": 1234,
  "project": "mi-proyecto"
}
```

### Niveles de Log
- `error`: Errores críticos
- `warn`: Advertencias importantes  
- `info`: Información general
- `debug`: Información detallada (solo en modo debug)

## 📊 Monitoreo y Estadísticas

### Estado del Sistema
```bash
# Script de estado completo
cat << 'EOF' > mcp-status.sh
#!/bin/bash
echo "🧠 MCP Memory System Status"
echo "=========================="

# Servidor
if [[ -f ".mcp-server.pid" ]]; then
    PID=$(cat .mcp-server.pid)
    if ps -p $PID > /dev/null 2>&1; then
        echo "✅ Server: Running (PID: $PID)"
    else
        echo "❌ Server: Stopped (PID file exists but process not running)"
    fi
else
    echo "❌ Server: Not started"
fi

# Memoria
if [[ -f ".mcp-memory/context.json" ]]; then
    SESSIONS=$(cat .mcp-memory/context.json | jq '.memory.data | length' 2>/dev/null || echo "0")
    echo "📊 Sessions: $SESSIONS stored"
    
    LAST_SESSION=$(cat .mcp-memory/context.json | jq -r '.memory.ultima_sesion.fecha' 2>/dev/null || echo "Unknown")
    echo "📅 Last session: $LAST_SESSION"
else
    echo "❌ Memory: No context file found"
fi

# Disco
MEMORY_SIZE=$(du -sh .mcp-memory 2>/dev/null | awk '{print $1}' || echo "Unknown")
echo "💾 Memory size: $MEMORY_SIZE"

echo "=========================="
EOF

chmod +x mcp-status.sh
./mcp-status.sh
```

### Métricas de Uso
```bash
# Número total de sesiones
cat .mcp-memory/context.json | jq '.memory.data | length'

# Sesiones por mes
cat .mcp-memory/context.json | jq '.memory.data | keys | group_by(.[0:7]) | map({month: .[0][0:7], count: length})'

# Temas más discutidos
cat .mcp-memory/context.json | jq '.memory.data[].temas_discutidos[]' | sort | uniq -c | sort -nr
```

## ⚡ Tips y Trucos

### Aliases Útiles
Agrega estos a tu `~/.zshrc`:

```bash
# MCP aliases
alias mcp-status='cat .mcp-server.pid 2>/dev/null && echo "MCP Running" || echo "MCP Stopped"'
alias mcp-logs='tail -f .mcp-server.log'
alias mcp-memory='cat .mcp-memory/context.json | jq .'
alias mcp-backup='cp .mcp-memory/context.json backup_$(date +%Y%m%d_%H%M%S).json'
alias mcp-restart='./stop-mcp.sh && ./auto-start-mcp.sh'
```

### Shortcuts de Teclado (VS Code)
Agrega a tu `keybindings.json`:

```json
[
  {
    "key": "cmd+shift+m cmd+s",
    "command": "workbench.action.tasks.runTask",
    "args": "💾 Auto-Save MCP Session"
  },
  {
    "key": "cmd+shift+m cmd+r",
    "command": "workbench.action.tasks.runTask", 
    "args": "Start MCP Memory Server"
  }
]
```

### Automatización con cron
```bash
# Backup automático diario (añadir a crontab)
0 23 * * * cd /path/to/project && ./auto-save-session.sh

# Editar crontab
crontab -e
```

¡Con esta guía tienes todo lo necesario para aprovechar al máximo tu sistema MCP! 🧠✨
