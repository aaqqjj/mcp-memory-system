# Changelog

Todos los cambios notables de este proyecto serán documentados en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
y este proyecto adhiere a [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- [ ] Soporte para Windows y Linux
- [ ] Interfaz web para gestión de memoria
- [ ] Sistema de plugins
- [ ] API REST para acceso remoto

## [1.0.0] - 2025-08-30

### Added
- 🧠 Sistema de memoria persistente basado en MCP
- 🌍 Auto-instalación global en cualquier proyecto
- 🔍 Auto-detección de tipos de proyecto
- 💾 Sistema de guardado automático de conversaciones
- 🎛️ Integración completa con VS Code
- 📝 Importación de historial completo de proyectos
- 🚀 Servidor MCP en TypeScript con stdio transport
- 🔄 Comandos globales: `mcp`, `save-session`, `mcp-save`
- 📋 Tasks automáticas de VS Code para inicio y guardado
- 🛠️ Scripts de control: `auto-start-mcp.sh`, `stop-mcp.sh`
- 📚 Documentación completa: README, INSTALLATION, USAGE, CONTRIBUTING
- ⚙️ Configuración personalizable por proyecto
- 🔧 Sistema de templates para nuevos proyectos
- 🧹 Limpieza automática de procesos y archivos temporales

### Features

#### Sistema Global
- **Auto-detección**: Detecta automáticamente proyectos de desarrollo (Node.js, Python, Rust, Go, etc.)
- **Instalación cero-configuración**: Solo ejecutar `mcp` en cualquier proyecto
- **Comando global**: Disponible desde cualquier directorio después de configuración
- **Template system**: Configuración automática de VS Code y estructura de archivos

#### Memoria Persistente
- **Conversaciones estructuradas**: Guarda temas, decisiones, próximos pasos
- **Contexto temporal**: Preserva timestamp exacto de cada sesión
- **Historial completo**: Importación de documentación existente del proyecto
- **Búsqueda y filtrado**: Acceso fácil a conversaciones anteriores

#### Guardado Automático
- **Auto-save silencioso**: Guardado transparente al cambiar directorios
- **Guardado manual completo**: Comando `save-session` para guardado detallado
- **Integración VS Code**: Auto-save automático al cerrar proyectos
- **Backup automático**: Preservación automática antes del apagado

#### Integración VS Code
- **Tasks automáticas**: Auto-inicio de MCP al abrir proyectos
- **Comandos integrados**: Acceso directo a funciones de guardado
- **Panel de tareas**: Control completo desde Command Palette
- **Configuración automática**: `.vscode/tasks.json` generado automáticamente

### Technical Details

#### Arquitectura
- **MCP Server**: TypeScript con @modelcontextprotocol/sdk
- **Transport**: stdio para comunicación con AI assistants
- **Storage**: JSON files para persistencia de memoria
- **Auto-detection**: Bash scripts para detección de proyectos
- **Global system**: Shell integration con PATH y aliases

#### Compatibilidad
- **Node.js**: 18.0.0 o superior
- **TypeScript**: 5.0.0 o superior
- **Sistema Operativo**: macOS (adaptable a Linux)
- **Shell**: zsh, bash compatible
- **Editores**: VS Code (principal), extensible a otros

#### Performance
- **Inicio rápido**: ~2-3 segundos para proyectos nuevos
- **Memoria ligera**: <10MB en RAM para servidor MCP
- **Almacenamiento eficiente**: JSON compacto para conversaciones
- **Auto-cleanup**: Limpieza automática de archivos temporales

### Security
- **Local storage**: Toda la memoria se almacena localmente
- **No external calls**: Sin comunicación externa sin consentimiento
- **Process isolation**: Servidor MCP en proceso separado
- **Permission control**: Scripts ejecutables solo con permisos explícitos

### Documentation
- **README completo**: Descripción, instalación, uso básico
- **INSTALLATION.md**: Guía detallada paso a paso
- **USAGE.md**: Manual completo con ejemplos y tips
- **CONTRIBUTING.md**: Guía para contribuidores
- **Inline documentation**: Comentarios en código y scripts

## [0.9.0] - 2025-08-29 (Pre-release)

### Added
- Implementación inicial del servidor MCP
- Scripts básicos de auto-start y stop
- Sistema de memoria en JSON
- Detección básica de proyectos

### Changed
- Migración de implementación local a sistema global

### Fixed
- Errores de compilación TypeScript
- Problemas de permisos en scripts
- Conflictos ES module vs CommonJS

## [0.8.0] - 2025-08-28 (Development)

### Added
- Prototipo inicial del sistema de memoria
- Integración básica con VS Code
- Primeros scripts de automatización

---

## Versioning

- **MAJOR** version cuando se hacen cambios incompatibles en la API
- **MINOR** version cuando se agrega funcionalidad de manera compatible hacia atrás
- **PATCH** version cuando se hacen correcciones de bugs compatibles hacia atrás

## Tipos de Cambios

- `Added` para nuevas funcionalidades
- `Changed` para cambios en funcionalidades existentes
- `Deprecated` para funcionalidades que serán removidas en próximas versiones
- `Removed` para funcionalidades removidas
- `Fixed` para corrección de bugs
- `Security` para vulnerabilidades de seguridad

## Links

- [Keep a Changelog](https://keepachangelog.com/)
- [Semantic Versioning](https://semver.org/)
- [Conventional Commits](https://www.conventionalcommits.org/)
