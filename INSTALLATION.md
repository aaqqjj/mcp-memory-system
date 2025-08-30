# 📋 Guía de Instalación Detallada

## 🔧 Requisitos del Sistema

### Software Requerido
- **Node.js**: v18.0.0 o superior
- **npm**: v8.0.0 o superior  
- **TypeScript**: v5.0.0 o superior (se instala automáticamente)
- **Sistema Operativo**: macOS (adaptable a Linux/Windows)
- **Shell**: zsh (bash compatible)

### Verificar Requisitos
```bash
# Verificar Node.js
node --version

# Verificar npm
npm --version

# Verificar shell
echo $SHELL
```

## 🚀 Instalación Paso a Paso

### Opción 1: Instalación Global (Recomendada)

#### 1. Descargar el Sistema
```bash
# Clonar repositorio
git clone https://github.com/tuusuario/mcp-memory-system.git
cd mcp-memory-system

# O descargar como ZIP y extraer
wget https://github.com/tuusuario/mcp-memory-system/archive/main.zip
unzip main.zip
cd mcp-memory-system-main
```

#### 2. Configurar Ubicación Global
```bash
# Crear directorio global (personalizable)
sudo mkdir -p /usr/local/mcp
sudo cp -r * /usr/local/mcp/
sudo chown -R $USER:$USER /usr/local/mcp/

# O usar directorio en home (sin sudo)
mkdir -p ~/MCP
cp -r * ~/MCP/
```

#### 3. Ejecutar Configuración Global
```bash
# Navegar a directorio global
cd /usr/local/mcp  # o cd ~/MCP

# Ejecutar configurador
./configure-mcp-global.sh
```

#### 4. Configurar PATH y Aliases
```bash
# Para instalación en /usr/local/mcp
echo 'export PATH="/usr/local/mcp:$PATH"' >> ~/.zshrc

# Para instalación en ~/MCP  
echo 'export PATH="~/MCP:$PATH"' >> ~/.zshrc

# Agregar aliases útiles
echo 'alias mcp-save="./auto-save-session.sh"' >> ~/.zshrc
echo 'alias save-session="./guardar-sesion-actual.sh"' >> ~/.zshrc
echo 'alias mcp-status="cat .mcp-server.pid 2>/dev/null && echo \"MCP Running\" || echo \"MCP Stopped\""' >> ~/.zshrc

# Recargar configuración
source ~/.zshrc
```

#### 5. Verificar Instalación
```bash
# Verificar comando global
which mcp

# Probar en proyecto de prueba
mkdir -p /tmp/test-mcp && cd /tmp/test-mcp
echo '{"name": "test"}' > package.json
mcp

# Limpiar después de la prueba
cd /tmp && rm -rf test-mcp
```

### Opción 2: Instalación Local por Proyecto

#### 1. Copiar a Proyecto
```bash
# Navegar a tu proyecto
cd /path/to/your/project

# Copiar archivos MCP
cp -r /path/to/mcp-memory-system/* ./
```

#### 2. Instalar Dependencias
```bash
# Instalar dependencias del servidor MCP
cd mcp-memory-server
npm install
npm run build
cd ..
```

#### 3. Configurar Proyecto
```bash
# Hacer scripts ejecutables
chmod +x *.sh

# Personalizar nombre del proyecto
PROJECT_NAME=$(basename $(pwd))
sed -i.bak "s/perito-forense-web/$PROJECT_NAME/g" mcp-memory-server/src/simple-index.ts
rm -f mcp-memory-server/src/simple-index.ts.bak

# Recompilar
cd mcp-memory-server && npm run build && cd ..
```

#### 4. Iniciar Sistema
```bash
./auto-start-mcp.sh
```

## 🔧 Configuración Personalizada

### Variables de Entorno
Crea un archivo `.env` en el directorio raíz del MCP:

```bash
# .env
MCP_GLOBAL_PATH="/usr/local/mcp"
MCP_AUTO_SAVE_INTERVAL=300
MCP_DEBUG=false
MCP_LOG_LEVEL="info"
MCP_MEMORY_RETENTION_DAYS=30
MCP_BACKUP_ENABLED=true
```

### Configuración de Proyecto
Edita `project-config.json`:

```json
{
  "project_name": "mi-proyecto-personalizado",
  "auto_save_interval": 300,
  "memory_retention_days": 30,
  "enable_debug": false,
  "backup_frequency": "daily",
  "integrations": {
    "vscode": true,
    "github": false,
    "slack": false
  }
}
```

### Personalizar Scripts

#### Auto-detección Personalizada
Edita `auto-mcp-detector.sh` para agregar nuevos tipos de proyecto:

```bash
# Agregar en la función is_dev_project()
if [[ -f "requirements.txt" ]] || [[ -f "setup.py" ]] || \
   [[ -f "pyproject.toml" ]] || [[ -f "poetry.lock" ]]; then
    return 0
fi
```

#### Guardado Personalizado
Modifica `guardar-sesion-actual.sh` para cambiar formato de guardado:

```bash
# Cambiar formato de timestamp
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
SESSION_ID="session_${TIMESTAMP}"
```

## 🐛 Troubleshooting

### Problema: Comando 'mcp' no encontrado

#### Solución:
```bash
# Verificar PATH
echo $PATH | grep -i mcp

# Re-agregar al PATH
echo 'export PATH="/usr/local/mcp:$PATH"' >> ~/.zshrc
source ~/.zshrc

# Verificar permisos
ls -la /usr/local/mcp/mcp-global.sh
chmod +x /usr/local/mcp/mcp-global.sh
```

### Problema: MCP no inicia automáticamente

#### Solución:
```bash
# Verificar dependencias
cd mcp-memory-server
npm install
npm run build

# Verificar permisos
chmod +x auto-start-mcp.sh

# Iniciar manualmente
./auto-start-mcp.sh

# Ver logs
cat .mcp-server.log
```

### Problema: Memoria no se preserva

#### Solución:
```bash
# Verificar directorio de memoria
ls -la .mcp-memory/

# Verificar permisos
chmod 755 .mcp-memory/
chmod 644 .mcp-memory/context.json

# Verificar servidor
ps aux | grep mcp
cat .mcp-server.pid
```

### Problema: TypeScript compilation errors

#### Solución:
```bash
# Reinstalar dependencias
cd mcp-memory-server
rm -rf node_modules package-lock.json
npm install

# Verificar versión de TypeScript
npx tsc --version

# Compilar manualmente
npx tsc
```

## 🔄 Actualización del Sistema

### Actualización Automática
```bash
# Navegar al directorio MCP global
cd /usr/local/mcp  # o cd ~/MCP

# Descargar última versión
git pull origin main

# Actualizar dependencias
cd mcp-memory-server
npm update
npm run build
cd ..

# Reconfigurar si es necesario
./configure-mcp-global.sh
```

### Actualización Manual
```bash
# Backup configuración actual
cp project-config.json project-config.json.backup

# Descargar nueva versión
wget https://github.com/tuusuario/mcp-memory-system/archive/main.zip
unzip main.zip

# Copiar archivos (conservar configuración)
cp mcp-memory-system-main/* ./
cp project-config.json.backup project-config.json

# Recompilar
cd mcp-memory-server && npm install && npm run build && cd ..
```

## 📋 Verificación de Instalación

### Script de Verificación
Guarda como `verify-mcp.sh`:

```bash
#!/bin/bash

echo "🔍 Verificando instalación MCP..."

# Verificar comando global
if command -v mcp &> /dev/null; then
    echo "✅ Comando 'mcp' disponible"
else
    echo "❌ Comando 'mcp' no encontrado"
fi

# Verificar Node.js
if command -v node &> /dev/null; then
    echo "✅ Node.js: $(node --version)"
else
    echo "❌ Node.js no encontrado"
fi

# Verificar directorio global
if [[ -d "/usr/local/mcp" ]] || [[ -d "~/MCP" ]]; then
    echo "✅ Directorio global MCP encontrado"
else
    echo "❌ Directorio global MCP no encontrado"
fi

# Verificar scripts principales
for script in "auto-mcp-detector.sh" "auto-start-mcp.sh" "guardar-sesion-actual.sh"; do
    if [[ -f "$script" ]] && [[ -x "$script" ]]; then
        echo "✅ $script ejecutable"
    else
        echo "❌ $script no encontrado o no ejecutable"
    fi
done

echo "🎯 Verificación completada"
```

```bash
chmod +x verify-mcp.sh
./verify-mcp.sh
```

## 🎯 Próximos Pasos

Una vez instalado exitosamente:

1. **Navega a un proyecto**: `cd tu-proyecto`
2. **Ejecuta MCP**: `mcp`
3. **Verifica funcionamiento**: `cat .mcp-server.log`
4. **Prueba guardado**: `save-session`
5. **Explora VS Code tasks**: Abrir proyecto en VS Code

¡Tu sistema MCP está listo para mantener memoria persistente! 🧠✨
