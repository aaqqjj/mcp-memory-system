#!/bin/bash

# 🔍 Script de Verificación del MCP Memory System
# Verifica que todos los componentes estén listos para Git

set -e

# Colores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔍 Verificando MCP Memory System para Git...${NC}"
echo "=================================================="

# Función para verificar archivos
check_file() {
    local file=$1
    local description=$2
    
    if [[ -f "$file" ]]; then
        echo -e "${GREEN}✅ $description: $file${NC}"
        return 0
    else
        echo -e "${RED}❌ $description: $file NO ENCONTRADO${NC}"
        return 1
    fi
}

# Función para verificar directorios
check_directory() {
    local dir=$1
    local description=$2
    
    if [[ -d "$dir" ]]; then
        local count=$(find "$dir" -type f | wc -l | tr -d ' ')
        echo -e "${GREEN}✅ $description: $dir ($count archivos)${NC}"
        return 0
    else
        echo -e "${RED}❌ $description: $dir NO ENCONTRADO${NC}"
        return 1
    fi
}

# Función para verificar permisos ejecutables
check_executable() {
    local file=$1
    local description=$2
    
    if [[ -f "$file" ]] && [[ -x "$file" ]]; then
        echo -e "${GREEN}✅ $description: $file (ejecutable)${NC}"
        return 0
    elif [[ -f "$file" ]]; then
        echo -e "${YELLOW}⚠️  $description: $file (no ejecutable, arreglando...)${NC}"
        chmod +x "$file"
        echo -e "${GREEN}✅ $description: $file (ahora ejecutable)${NC}"
        return 0
    else
        echo -e "${RED}❌ $description: $file NO ENCONTRADO${NC}"
        return 1
    fi
}

# Variables
ERRORS=0

echo -e "${BLUE}📋 Verificando Documentación...${NC}"
check_file "README.md" "README principal" || ((ERRORS++))
check_file "INSTALLATION.md" "Guía de instalación" || ((ERRORS++))
check_file "USAGE.md" "Guía de uso" || ((ERRORS++))
check_file "CONTRIBUTING.md" "Guía de contribución" || ((ERRORS++))
check_file "LICENSE" "Licencia" || ((ERRORS++))
check_file "CHANGELOG.md" "Changelog" || ((ERRORS++))

echo ""
echo -e "${BLUE}📦 Verificando Archivos de Configuración...${NC}"
check_file "package.json" "Package.json principal" || ((ERRORS++))
check_file ".gitignore" "Git ignore" || ((ERRORS++))
check_file "project-config.json" "Configuración de proyecto" || ((ERRORS++))

echo ""
echo -e "${BLUE}🔧 Verificando Scripts Principales...${NC}"
check_executable "auto-mcp-detector.sh" "Auto-detector" || ((ERRORS++))
check_executable "mcp-global.sh" "Comando global MCP" || ((ERRORS++))
check_executable "configure-mcp-global.sh" "Configurador global" || ((ERRORS++))
check_executable "auto-start-mcp.sh" "Auto-start MCP" || ((ERRORS++))
check_executable "stop-mcp.sh" "Stop MCP" || ((ERRORS++))

echo ""
echo -e "${BLUE}💾 Verificando Scripts de Guardado...${NC}"
check_executable "guardar-sesion-actual.sh" "Guardado manual" || ((ERRORS++))
check_executable "auto-save-session.sh" "Auto-save" || ((ERRORS++))

echo ""
echo -e "${BLUE}🏗️ Verificando Servidor MCP...${NC}"
check_directory "mcp-memory-server" "Servidor MCP" || ((ERRORS++))
check_file "mcp-memory-server/package.json" "Package.json del servidor" || ((ERRORS++))
check_file "mcp-memory-server/tsconfig.json" "TypeScript config" || ((ERRORS++))
check_file "mcp-memory-server/src/simple-index.ts" "Código principal TS" || ((ERRORS++))

echo ""
echo -e "${BLUE}🎛️ Verificando Templates VS Code...${NC}"
check_directory ".vscode-template" "Template VS Code" || ((ERRORS++))
check_file ".vscode-template/tasks.json" "Tasks de VS Code" || ((ERRORS++))

echo ""
echo -e "${BLUE}📁 Verificando Estructura de Directorios...${NC}"
check_directory "docs" "Documentación" || ((ERRORS++))
check_directory "examples" "Ejemplos" || ((ERRORS++))
check_directory "tests" "Tests" || ((ERRORS++))

echo ""
echo -e "${BLUE}🧹 Limpieza de Archivos Temporales...${NC}"

# Limpiar archivos temporales que no deben ir al Git
find . -name "*.log" -delete 2>/dev/null && echo -e "${GREEN}✅ Logs limpiados${NC}" || true
find . -name "*.pid" -delete 2>/dev/null && echo -e "${GREEN}✅ PIDs limpiados${NC}" || true
find . -name ".DS_Store" -delete 2>/dev/null && echo -e "${GREEN}✅ .DS_Store limpiados${NC}" || true
rm -rf .mcp-memory 2>/dev/null && echo -e "${GREEN}✅ Directorio .mcp-memory limpiado${NC}" || true
rm -f .mcp-installed 2>/dev/null && echo -e "${GREEN}✅ Marcador de instalación limpiado${NC}" || true

echo ""
echo -e "${BLUE}📊 Generando Estadísticas...${NC}"

# Contar archivos por tipo
TOTAL_FILES=$(find . -type f | wc -l | tr -d ' ')
SHELL_SCRIPTS=$(find . -name "*.sh" | wc -l | tr -d ' ')
TS_FILES=$(find . -name "*.ts" | wc -l | tr -d ' ')
MD_FILES=$(find . -name "*.md" | wc -l | tr -d ' ')
JSON_FILES=$(find . -name "*.json" | wc -l | tr -d ' ')

echo -e "${GREEN}📈 Estadísticas del Proyecto:${NC}"
echo "   Total de archivos: $TOTAL_FILES"
echo "   Scripts shell: $SHELL_SCRIPTS"
echo "   Archivos TypeScript: $TS_FILES"
echo "   Documentos Markdown: $MD_FILES"
echo "   Archivos JSON: $JSON_FILES"

# Calcular tamaño
TOTAL_SIZE=$(du -sh . | awk '{print $1}')
echo "   Tamaño total: $TOTAL_SIZE"

echo ""
echo -e "${BLUE}🔍 Verificación Final...${NC}"

if [[ $ERRORS -eq 0 ]]; then
    echo -e "${GREEN}🎉 ¡VERIFICACIÓN EXITOSA!${NC}"
    echo -e "${GREEN}=============================${NC}"
    echo -e "${GREEN}✅ Todos los archivos están presentes${NC}"
    echo -e "${GREEN}✅ Todos los scripts son ejecutables${NC}"
    echo -e "${GREEN}✅ Estructura de directorios correcta${NC}"
    echo -e "${GREEN}✅ Archivos temporales limpiados${NC}"
    echo ""
    echo -e "${BLUE}🚀 El proyecto está listo para Git!${NC}"
    echo ""
    echo -e "${YELLOW}💡 Próximos pasos sugeridos:${NC}"
    echo "   1. git init"
    echo "   2. git add ."
    echo "   3. git commit -m 'feat: initial MCP Memory System implementation'"
    echo "   4. git remote add origin https://github.com/tu-usuario/mcp-memory-system.git"
    echo "   5. git push -u origin main"
    echo ""
    exit 0
else
    echo -e "${RED}❌ VERIFICACIÓN FALLÓ${NC}"
    echo -e "${RED}========================${NC}"
    echo -e "${RED}Se encontraron $ERRORS errores${NC}"
    echo -e "${RED}Por favor corrige los problemas antes de subir a Git${NC}"
    echo ""
    exit 1
fi
