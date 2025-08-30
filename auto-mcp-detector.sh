#!/bin/bash

# 🧠 MCP Auto-Detector y Auto-Installer Global
# Este script detecta automáticamente si un proyecto necesita MCP y lo instala
# ACTUALIZADO: Incluye sistema de guardado automático de conversaciones

MCP_GLOBAL_PATH="/Users/manuelfernandezdelreal/MCP"
PROJECT_MCP_MARKER=".mcp-installed"
CURRENT_DIR=$(pwd)
PROJECT_NAME=$(basename "$CURRENT_DIR")

# Colores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}🧠 MCP Auto-Detector iniciado...${NC}"
echo -e "${BLUE}📂 Proyecto actual: ${PROJECT_NAME}${NC}"
echo -e "${BLUE}📍 Directorio: ${CURRENT_DIR}${NC}"

# Función para detectar si es un proyecto de desarrollo
is_dev_project() {
    # Buscar indicadores de proyecto de desarrollo
    if [[ -f "package.json" ]] || [[ -f "requirements.txt" ]] || [[ -f "Cargo.toml" ]] || \
       [[ -f "pom.xml" ]] || [[ -f "build.gradle" ]] || [[ -f "composer.json" ]] || \
       [[ -f "Gemfile" ]] || [[ -f "go.mod" ]] || [[ -f "pyproject.toml" ]] || \
       [[ -f "CMakeLists.txt" ]] || [[ -f "Makefile" ]] || [[ -f "astro.config.ts" ]] || \
       [[ -f "next.config.js" ]] || [[ -f "vite.config.js" ]] || [[ -f "webpack.config.js" ]] || \
       [[ -d "src" ]] || [[ -d ".git" ]]; then
        return 0
    fi
    return 1
}

# Función para detectar si MCP ya está instalado
is_mcp_installed() {
    if [[ -f "$PROJECT_MCP_MARKER" ]] && [[ -f "auto-start-mcp.sh" ]] && [[ -d "mcp-memory-server" ]]; then
        return 0
    fi
    return 1
}

# Función para detectar si el sistema de guardado está instalado
is_autosave_installed() {
    if [[ -f "guardar-sesion-actual.sh" ]] && [[ -f "auto-save-session.sh" ]]; then
        return 0
    fi
    return 1
}

# Función para instalar MCP
install_mcp() {
    echo -e "${YELLOW}🚀 Instalando MCP Memory System para: $PROJECT_NAME${NC}"
    
    # Copiar archivos MCP básicos
    cp -r "$MCP_GLOBAL_PATH/mcp-memory-server" ./
    cp "$MCP_GLOBAL_PATH/auto-start-mcp.sh" ./
    cp "$MCP_GLOBAL_PATH/stop-mcp.sh" ./
    
    # 💾 NUEVO: Copiar sistema de guardado automático
    echo -e "${BLUE}💾 Instalando sistema de guardado automático...${NC}"
    cp "$MCP_GLOBAL_PATH/guardar-sesion-actual.sh" ./
    cp "$MCP_GLOBAL_PATH/auto-save-session.sh" ./
    
    # Crear .vscode si no existe y copiar template con auto-save
    mkdir -p .vscode
    if [[ -d "$MCP_GLOBAL_PATH/.vscode-template" ]]; then
        cp -r "$MCP_GLOBAL_PATH/.vscode-template"/* .vscode/ 2>/dev/null || true
        echo -e "${GREEN}✅ VS Code tasks con auto-save configuradas${NC}"
    fi
    
    # Hacer scripts ejecutables
    chmod +x auto-start-mcp.sh
    chmod +x stop-mcp.sh
    chmod +x guardar-sesion-actual.sh
    chmod +x auto-save-session.sh
    
    # Personalizar para el proyecto actual
    if [[ -f "mcp-memory-server/src/simple-index.ts" ]]; then
        sed -i.bak "s/perito-forense-web/$PROJECT_NAME/g" mcp-memory-server/src/simple-index.ts
        rm -f mcp-memory-server/src/simple-index.ts.bak
    fi
    
    # Instalar dependencias y compilar
    echo -e "${BLUE}📦 Instalando dependencias MCP...${NC}"
    cd mcp-memory-server
    npm install --silent > /dev/null 2>&1
    npm run build --silent > /dev/null 2>&1
    cd ..
    
    # Crear directorio de memoria
    mkdir -p .mcp-memory
    
    # Marcar como instalado
    echo "MCP + Auto-Save instalado automáticamente el $(date)" > "$PROJECT_MCP_MARKER"
    echo "Proyecto: $PROJECT_NAME" >> "$PROJECT_MCP_MARKER"
    echo "Directorio: $CURRENT_DIR" >> "$PROJECT_MCP_MARKER"
    echo "Sistema de guardado automático: ✅ Incluido" >> "$PROJECT_MCP_MARKER"
    
    echo -e "${GREEN}✅ MCP Memory System + Auto-Save instalado para: $PROJECT_NAME${NC}"
    return 0
}

# Función para instalar solo el sistema de guardado automático
install_autosave_only() {
    echo -e "${YELLOW}💾 Instalando sistema de guardado automático...${NC}"
    
    # Copiar scripts de guardado
    cp "$MCP_GLOBAL_PATH/guardar-sesion-actual.sh" ./
    cp "$MCP_GLOBAL_PATH/auto-save-session.sh" ./
    
    # Hacer ejecutables
    chmod +x guardar-sesion-actual.sh
    chmod +x auto-save-session.sh
    
    # Actualizar .vscode/tasks.json si existe
    mkdir -p .vscode
    if [[ -f "$MCP_GLOBAL_PATH/.vscode-template/tasks.json" ]]; then
        cp "$MCP_GLOBAL_PATH/.vscode-template/tasks.json" .vscode/
        echo -e "${GREEN}✅ VS Code tasks con auto-save actualizadas${NC}"
    fi
    
    # Actualizar marcador
    if [[ -f "$PROJECT_MCP_MARKER" ]]; then
        echo "Sistema de guardado automático: ✅ Actualizado $(date)" >> "$PROJECT_MCP_MARKER"
    fi
    
    echo -e "${GREEN}✅ Sistema de guardado automático instalado${NC}"
}

# Función para iniciar MCP
start_mcp() {
    echo -e "${BLUE}🔄 Iniciando MCP Memory System...${NC}"
    ./auto-start-mcp.sh
}

# LÓGICA PRINCIPAL
echo ""

# Verificar si es un proyecto de desarrollo
if ! is_dev_project; then
    echo -e "${YELLOW}ℹ️  No parece ser un proyecto de desarrollo${NC}"
    echo -e "${YELLOW}📝 Tip: Ejecuta desde la raíz de tu proyecto${NC}"
    exit 0
fi

echo -e "${GREEN}✅ Proyecto de desarrollo detectado${NC}"

# Verificar estados de instalación
MCP_INSTALLED=$(is_mcp_installed && echo "true" || echo "false")
AUTOSAVE_INSTALLED=$(is_autosave_installed && echo "true" || echo "false")

if [[ "$MCP_INSTALLED" == "true" ]] && [[ "$AUTOSAVE_INSTALLED" == "true" ]]; then
    echo -e "${GREEN}✅ MCP + Sistema de guardado automático ya instalados${NC}"
    
    # Verificar si está corriendo
    if [[ -f ".mcp-server.pid" ]]; then
        PID=$(cat .mcp-server.pid)
        if ps -p $PID > /dev/null 2>&1; then
            echo -e "${GREEN}✅ MCP Memory System ya está corriendo (PID: $PID)${NC}"
            echo -e "${GREEN}🧠 Memoria persistente activa${NC}"
            echo -e "${GREEN}💾 Auto-save automático activado${NC}"
        else
            echo -e "${YELLOW}🔄 MCP instalado pero no corriendo, iniciando...${NC}"
            start_mcp
        fi
    else
        echo -e "${YELLOW}🔄 MCP instalado pero no corriendo, iniciando...${NC}"
        start_mcp
    fi
    
elif [[ "$MCP_INSTALLED" == "true" ]] && [[ "$AUTOSAVE_INSTALLED" == "false" ]]; then
    echo -e "${YELLOW}📥 MCP instalado, pero falta sistema de guardado automático${NC}"
    install_autosave_only
    
elif [[ "$MCP_INSTALLED" == "false" ]]; then
    echo -e "${YELLOW}📥 MCP no encontrado, instalando sistema completo...${NC}"
    
    # Instalar MCP completo con auto-save
    if install_mcp; then
        echo ""
        echo -e "${GREEN}🎉 ¡MCP + Auto-Save instalado exitosamente!${NC}"
        echo ""
        echo -e "${BLUE}🚀 Iniciando sistema de memoria...${NC}"
        start_mcp
    else
        echo -e "${RED}❌ Error al instalar MCP${NC}"
        exit 1
    fi
fi

echo ""
echo -e "${GREEN}🎯 SISTEMA MCP COMPLETO LISTO${NC}"
echo -e "${GREEN}===============================${NC}"
echo -e "${GREEN}• Proyecto: $PROJECT_NAME${NC}"
echo -e "${GREEN}• Memoria persistente: ✅ Activa${NC}"
echo -e "${GREEN}• Auto-backup: ✅ Activado${NC}"
echo -e "${GREEN}• Auto-save conversaciones: ✅ Activado${NC}"
echo -e "${GREEN}• AI Context: ✅ Disponible${NC}"
echo ""
echo -e "${BLUE}💡 Comandos útiles:${NC}"
echo -e "${BLUE}   ./auto-start-mcp.sh     - Iniciar MCP${NC}"
echo -e "${BLUE}   ./stop-mcp.sh           - Detener MCP${NC}"
echo -e "${BLUE}   ./guardar-sesion-actual.sh - Guardar sesión manualmente${NC}"
echo -e "${BLUE}   save-session            - Alias para guardar sesión${NC}"
echo -e "${BLUE}   cat .mcp-server.log     - Ver logs${NC}"
