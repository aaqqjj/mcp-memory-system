# 🧠 MCP Memory Server para Perito Forense Web

Servidor MCP (Model Context Protocol) personalizado para mantener memoria persistente del proyecto.

## 🚀 Características

- **Memoria Persistente**: Guarda y recupera información entre sesiones
- **Contexto del Proyecto**: Estado completo siempre disponible  
- **Búsqueda Inteligente**: Encuentra información rápidamente
- **Categorización**: Organiza información por tipos
- **Historial de Sesiones**: Tracking de trabajo realizado

## 🔧 Instalación y Configuración

### 1. Compilar el Servidor
```bash
cd mcp-memory-server
npm install
npm run build
```

### 2. Configurar en VS Code

Añadir a tu `settings.json` de VS Code:

```json
{
  "mcp.servers": {
    "perito-forense-memory": {
      "command": "node",
      "args": ["/Users/manuelfernandezdelreal/peritoForenseMain/perito-forense-web/mcp-memory-server/dist/simple-index.js"],
      "env": {}
    }
  }
}
```

### 3. Configurar en Claude Desktop

Añadir al archivo de configuración de Claude:

```json
{
  "mcpServers": {
    "perito-forense-memory": {
      "command": "node",
      "args": ["/Users/manuelfernandezdelreal/peritoForenseMain/perito-forense-web/mcp-memory-server/dist/simple-index.js"]
    }
  }
}
```

## 🎯 Herramientas Disponibles

### `save_memory`
Guarda información importante en memoria persistente
```json
{
  "key": "og-optimization-complete",
  "value": "Todas las imágenes OG han sido optimizadas a WebP <25KB",
  "category": "feature"
}
```

### `get_memory`
Recupera información guardada
```json
{
  "key": "og-optimization-complete"
}
```

### `get_project_status`
Obtiene el estado completo del proyecto

### `save_session`
Guarda el contexto de la sesión actual
```json
{
  "summary": "Completada optimización de imágenes OG",
  "achievements": ["Home OG optimizada", "About OG optimizada"],
  "nextActions": ["Optimizar servicios OG", "Testing en producción"]
}
```

### `search_memory`
Busca información en la memoria
```json
{
  "query": "SEO"
}
```

## 📋 Recursos Disponibles

- `memory://context` - Contexto completo del proyecto
- `memory://status` - Estado actual resumido

## 🗂️ Categorías de Memoria

- **feature**: Características implementadas
- **bug**: Problemas encontrados y solucionados
- **task**: Tareas pendientes o completadas
- **note**: Notas importantes del proyecto
- **config**: Configuraciones importantes

## 💡 Ejemplos de Uso

### Guardar un logro importante
```json
{
  "tool": "save_memory",
  "args": {
    "key": "seo-system-complete",
    "value": "Sistema SEO completo implementado con meta tags dinámicos, Open Graph completo y Schema.org",
    "category": "feature"
  }
}
```

### Buscar información sobre imágenes
```json
{
  "tool": "search_memory", 
  "args": {
    "query": "imagen"
  }
}
```

### Guardar sesión de trabajo
```json
{
  "tool": "save_session",
  "args": {
    "summary": "Implementación del sistema MCP para memoria persistente",
    "achievements": [
      "Servidor MCP creado y funcionando",
      "Configuración de VS Code lista",
      "Documentación completa"
    ],
    "nextActions": [
      "Probar integración con Claude",
      "Añadir más categorías de memoria",
      "Crear scripts de backup"
    ]
  }
}
```

## 🔄 Flujo de Trabajo Recomendado

1. **Al iniciar sesión**: `get_project_status` para contexto
2. **Durante el trabajo**: `save_memory` para hitos importantes
3. **Al finalizar**: `save_session` con resumen del trabajo
4. **Para buscar**: `search_memory` para encontrar información

## 📁 Ubicación de Datos

Los datos se guardan en: `.mcp-memory/context.json`

Este archivo contiene toda la memoria persistente del proyecto y puede ser:
- Versionado en Git (recomendado)
- Respaldado automáticamente  
- Compartido entre desarrolladores

## 🚨 Solución de Problemas

### Servidor no inicia
```bash
# Verificar compilación
npm run build

# Probar manualmente
node dist/simple-index.js
```

### Error de permisos
```bash
chmod +x dist/simple-index.js
```

### Datos corruptos
```bash
# Resetear memoria
rm .mcp-memory/context.json
# El servidor recreará el archivo al iniciarse
```

---

## 🎯 ¡Tu Proyecto Ahora Tiene Memoria Persistente Real!

Con este MCP server, cualquier AI assistant podrá:
- Recordar el estado exacto del proyecto
- Acceder a toda la información guardada
- Continuar donde se quedó la sesión anterior
- Mantener contexto entre reinicios

**¡La memoria persistente ya no es un problema!** 🧠✨
