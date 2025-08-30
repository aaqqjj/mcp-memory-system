#!/bin/bash

# 🧠 Configuración Global de MCP
# Este script configura MCP para que funcione desde cualquier proyecto

echo "🔧 Configurando MCP Global..."

# Detectar shell
SHELL_RC=""
if [[ "$SHELL" == *"zsh"* ]]; then
    SHELL_RC="$HOME/.zshrc"
elif [[ "$SHELL" == *"bash"* ]]; then
    SHELL_RC="$HOME/.bashrc"
fi

if [[ -z "$SHELL_RC" ]]; then
    echo "❌ Shell no detectado automáticamente"
    echo "💡 Añade manualmente a tu .bashrc o .zshrc:"
    echo 'export PATH="$HOME/.local/bin:$PATH"'
    echo 'alias mcp="/Users/manuelfernandezdelreal/MCP/mcp-global.sh"'
    exit 1
fi

echo "📝 Configurando shell: $SHELL_RC"

# Backup del archivo de configuración
cp "$SHELL_RC" "$SHELL_RC.backup.$(date +%Y%m%d_%H%M%S)" 2>/dev/null || true

# Agregar PATH si no existe
if ! grep -q ".local/bin" "$SHELL_RC" 2>/dev/null; then
    echo "" >> "$SHELL_RC"
    echo "# MCP Global Configuration" >> "$SHELL_RC"
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_RC"
    echo "✅ PATH configurado"
else
    echo "✅ PATH ya configurado"
fi

# Agregar alias si no existe
if ! grep -q "alias mcp=" "$SHELL_RC" 2>/dev/null; then
    echo 'alias mcp="/Users/manuelfernandezdelreal/MCP/mcp-global.sh"' >> "$SHELL_RC"
    echo "✅ Alias mcp configurado"
else
    echo "✅ Alias mcp ya configurado"
fi

# Función de auto-detección en cd (opcional)
if ! grep -q "mcp_auto_detect" "$SHELL_RC" 2>/dev/null; then
    cat >> "$SHELL_RC" << 'EOL'

# MCP Auto-Detection en cambio de directorio (opcional)
# Descomenta las siguientes líneas para auto-detección automática:
# mcp_auto_detect() {
#     if [[ -f "package.json" ]] || [[ -f "requirements.txt" ]] || [[ -d ".git" ]]; then
#         if [[ ! -f ".mcp-installed" ]]; then
#             echo "🧠 Proyecto detectado. Ejecuta 'mcp' para instalar memoria persistente"
#         fi
#     fi
# }
# 
# chpwd() { mcp_auto_detect }  # Para zsh
# PROMPT_COMMAND="mcp_auto_detect; $PROMPT_COMMAND"  # Para bash
EOL
    echo "✅ Función de auto-detección agregada (comentada)"
fi

echo ""
echo "🎉 ¡Configuración completada!"
echo ""
echo "🔄 Para aplicar los cambios:"
echo "   source $SHELL_RC"
echo "   # O simplemente abre una nueva terminal"
echo ""
echo "🎯 Uso desde cualquier proyecto:"
echo "   cd /path/to/any/project"
echo "   mcp                    # Auto-instalar y iniciar"
echo "   mcp start              # Solo iniciar"
echo "   mcp stop               # Detener"
echo "   mcp status             # Ver estado"
echo ""
echo "🚀 ¡Tu MCP ahora es global y automático!"
