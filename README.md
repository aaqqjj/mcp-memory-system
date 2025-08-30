# 🧠 MCP Memory System - Sistema de Memoria Persistente

![MCP Version](https://img.shields.io/badge/MCP-v1.0.0-blue)
![Node.js](https://img.shields.io/badge/Node.js-18%2B-green)
![TypeScript](https://img.shields.io/badge/TypeScript-5.0%2B-blue)
![License](https://img.shields.io/badge/License-MIT-yellow)
![Platform](https://img.shields.io/badge/Platform-macOS-lightgrey)

## 📖 Descripción

**MCP Memory System** es un sistema de memoria persistente basado en **Model Context Protocol (MCP)** que permite a los asistentes de IA mantener conversaciones y contexto de manera persistente entre sesiones. Incluye un sistema completo de auto-instalación global, guardado automático de conversaciones, y detección automática de proyectos.

### ✨ Características Principales

- 🧠 **Memoria Persistente**: Conversaciones y contexto se preservan entre sesiones
- 🌍 **Sistema Global**: Se instala una vez y funciona en todos los proyectos
- 🚀 **Auto-instalación**: Detección automática e instalación en proyectos nuevos
- 💾 **Guardado Automático**: Las conversaciones se guardan automáticamente antes del apagado
- 🎛️ **Integración VS Code**: Tasks automáticas y comandos integrados
- 📝 **Historial Completo**: Importación y preservación del historial de proyectos
- 🔄 **Cero Configuración**: Solo ejecuta `mcp` en cualquier proyecto

## � Instalación Rápida

### 1. Clonar el Repositorio
```bash
git clone https://github.com/tuusuario/mcp-memory-system.git
cd mcp-memory-system
```

### 2. Instalar Sistema Global
```bash
# Configurar sistema global
./configure-mcp-global.sh

# Agregar comando global al PATH
echo 'export PATH="/ruta/completa/al/mcp:$PATH"' >> ~/.zshrc
echo 'alias mcp-save="./auto-save-session.sh"' >> ~/.zshrc
echo 'alias save-session="./guardar-sesion-actual.sh"' >> ~/.zshrc
source ~/.zshrc
```

### 3. Usar en Cualquier Proyecto
```bash
cd tu-proyecto
mcp  # ¡Eso es todo! Se instala y configura automáticamente
```

## 🎯 Uso

### Comando Principal
```bash
mcp  # Detecta, instala y configura MCP automáticamente
```

### Comandos de Guardado
```bash
save-session      # Guardar conversación actual manualmente
mcp-save         # Auto-save rápido
```

### Comandos de Control
```bash
./auto-start-mcp.sh    # Iniciar servidor MCP
./stop-mcp.sh          # Detener servidor MCP
```
- Instala dependencias

¡Tu memoria persistente está lista en cualquier proyecto! 🚀
