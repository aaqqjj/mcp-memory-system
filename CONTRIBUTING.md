# 🤝 Guía de Contribución

¡Gracias por tu interés en contribuir al MCP Memory System! Esta guía te ayudará a empezar.

## 📋 Tabla de Contenidos

- [Código de Conducta](#código-de-conducta)
- [¿Cómo puedo contribuir?](#cómo-puedo-contribuir)
- [Reportar Bugs](#reportar-bugs)
- [Sugerir Mejoras](#sugerir-mejoras)
- [Pull Requests](#pull-requests)
- [Guía de Desarrollo](#guía-de-desarrollo)
- [Estilo de Código](#estilo-de-código)
- [Testing](#testing)

## 📜 Código de Conducta

Este proyecto adhiere al [Contributor Covenant](https://www.contributor-covenant.org/). Al participar, se espera que respetes este código. Por favor reporta comportamiento inaceptable a [tu-email@dominio.com].

### Nuestros Compromisos

- Mantener un ambiente acogedor e inclusivo
- Respetar diferentes puntos de vista y experiencias
- Aceptar críticas constructivas con gracia
- Enfocarse en lo que es mejor para la comunidad
- Mostrar empatía hacia otros miembros de la comunidad

## 🔧 ¿Cómo puedo contribuir?

### 🐛 Reportar Bugs

Los bugs se rastean como [GitHub Issues](https://github.com/tuusuario/mcp-memory-system/issues). Antes de crear un bug report:

1. **Verifica** que no sea un duplicado buscando en issues existentes
2. **Determina** en qué repositorio debería reportarse el bug
3. **Usa** el template de bug report

#### Template de Bug Report

```markdown
**Describe el bug**
Una descripción clara y concisa del problema.

**Para Reproducir**
Pasos para reproducir el comportamiento:
1. Ve a '...'
2. Haz clic en '....'
3. Desplázate hacia '....'
4. Ve el error

**Comportamiento Esperado**
Descripción clara de lo que esperabas que pasara.

**Screenshots**
Si aplica, agrega screenshots para ayudar a explicar el problema.

**Entorno (completa la información siguiente):**
 - OS: [e.g. macOS 12.0]
 - Node.js: [e.g. 18.17.0]
 - MCP Version: [e.g. 1.0.0]
 - Shell: [e.g. zsh 5.8]

**Contexto Adicional**
Cualquier otro contexto sobre el problema.

**Logs**
```bash
# Incluir logs relevantes
cat .mcp-server.log
```
```

### 💡 Sugerir Mejoras

Las mejoras también se rastean como [GitHub Issues](https://github.com/tuusuario/mcp-memory-system/issues). Antes de crear una sugerencia:

1. **Verifica** que no exista ya una sugerencia similar
2. **Determina** si tu idea encaja con el alcance del proyecto
3. **Usa** el template de feature request

#### Template de Feature Request

```markdown
**¿Tu feature request está relacionado con un problema? Por favor describe.**
Una descripción clara del problema. Ej. Siempre me frustra cuando [...]

**Describe la solución que te gustaría**
Descripción clara de lo que quieres que suceda.

**Describe alternativas que has considerado**
Descripción de soluciones o features alternativas que has considerado.

**Contexto Adicional**
Cualquier otro contexto o screenshots sobre el feature request.

**Mockups/Diseños**
Si tienes mockups o diseños, inclúyelos aquí.
```

## 🔄 Pull Requests

### Proceso de PR

1. **Fork** el repositorio
2. **Crea** una branch desde `main`: `git checkout -b feature/amazing-feature`
3. **Haz** tus cambios
4. **Agrega** tests si es aplicable
5. **Ejecuta** el test suite: `npm test`
6. **Commit** tus cambios: `git commit -m 'Add amazing feature'`
7. **Push** a la branch: `git push origin feature/amazing-feature`
8. **Abre** un Pull Request

### Convenciones de Branch

- `feature/` - Nueva funcionalidad
- `bugfix/` - Corrección de bugs
- `hotfix/` - Correcciones urgentes
- `docs/` - Cambios en documentación
- `refactor/` - Refactoring de código
- `test/` - Agregar o mejorar tests

### Template de Pull Request

```markdown
## Descripción

Descripción breve de los cambios incluidos en este PR.

## Tipo de cambio

- [ ] Bug fix (cambio que no rompe nada y corrige un issue)
- [ ] Nueva feature (cambio que no rompe nada y agrega funcionalidad)
- [ ] Breaking change (fix o feature que causaría que funcionalidad existente no funcione como antes)
- [ ] Cambio de documentación

## ¿Cómo se ha probado?

Describe las pruebas que realizaste para verificar tus cambios.

## Lista de verificación:

- [ ] Mi código sigue las pautas de estilo de este proyecto
- [ ] He realizado una auto-revisión de mi código
- [ ] He comentado mi código, particularmente en áreas difíciles de entender
- [ ] He hecho cambios correspondientes a la documentación
- [ ] Mis cambios no generan nuevos warnings
- [ ] He agregado tests que prueban que mi fix es efectivo o que mi feature funciona
- [ ] Tests nuevos y existentes pasan localmente con mis cambios
```

## 🛠️ Guía de Desarrollo

### Configurar Entorno de Desarrollo

```bash
# 1. Fork y clonar el repositorio
git clone https://github.com/tu-usuario/mcp-memory-system.git
cd mcp-memory-system

# 2. Instalar dependencias
cd mcp-memory-server
npm install
cd ..

# 3. Configurar hooks de git
cp .hooks/pre-commit .git/hooks/
chmod +x .git/hooks/pre-commit

# 4. Crear branch para desarrollo
git checkout -b feature/mi-nueva-feature
```

### Estructura del Proyecto para Desarrollo

```
mcp-memory-system/
├── 🧪 tests/                      # Tests automatizados
│   ├── unit/                      # Tests unitarios
│   ├── integration/               # Tests de integración
│   └── fixtures/                  # Datos de prueba
├── 📁 src/                        # Código fuente organizado
│   ├── scripts/                   # Scripts bash organizados
│   ├── server/                    # Código del servidor
│   └── templates/                 # Templates de configuración
├── 📁 docs/                       # Documentación adicional
├── 📁 examples/                   # Ejemplos de uso
├── 🔧 .hooks/                     # Git hooks
└── 🔧 .github/                    # GitHub templates y workflows
```

### Scripts de Desarrollo

```bash
# Testing
npm test                    # Ejecutar todos los tests
npm run test:unit          # Solo tests unitarios
npm run test:integration   # Solo tests de integración
npm run test:watch         # Tests en modo watch

# Linting y Formato
npm run lint               # Verificar estilo de código
npm run lint:fix           # Corregir automáticamente
npm run format             # Formatear código

# Build
npm run build              # Compilar TypeScript
npm run build:watch        # Compilar en modo watch

# Desarrollo
npm run dev                # Modo desarrollo con recarga automática
npm run debug              # Modo debug con breakpoints
```

## 🎨 Estilo de Código

### JavaScript/TypeScript

Usamos [ESLint](https://eslint.org/) y [Prettier](https://prettier.io/) para mantener consistencia.

```javascript
// ✅ Bueno
const getUserData = async (userId: string): Promise<UserData> => {
  try {
    const response = await fetch(`/api/users/${userId}`);
    return await response.json();
  } catch (error) {
    console.error('Error fetching user data:', error);
    throw error;
  }
};

// ❌ Malo
function getUserData(userId){
    fetch("/api/users/"+userId).then(response=>{
        return response.json()
    }).catch(err=>{console.log(err)})
}
```

### Bash Scripts

```bash
#!/bin/bash

# ✅ Bueno
# Descripción clara del script
# Variables en MAYÚSCULAS para constantes
readonly PROJECT_NAME="mcp-memory-system"
readonly LOG_FILE=".mcp-server.log"

# Funciones con documentación
# @description: Inicia el servidor MCP
# @param: $1 - Puerto (opcional)
start_mcp_server() {
    local port=${1:-3000}
    
    if [[ -f "${LOG_FILE}" ]]; then
        echo "🚀 Iniciando servidor en puerto ${port}..."
        # Lógica del servidor
    else
        echo "❌ Error: Log file no encontrado" >&2
        return 1
    fi
}

# ❌ Malo
start(){
    PORT=3000
    echo "starting server"
    # sin validación ni documentación
}
```

### Mensajes de Commit

Seguimos [Conventional Commits](https://www.conventionalcommits.org/):

```bash
# Tipos
feat:     # Nueva funcionalidad
fix:      # Bug fix
docs:     # Documentación
style:    # Formateo, punto y coma faltante, etc.
refactor: # Refactoring
test:     # Agregar tests
chore:    # Tareas de mantenimiento

# Ejemplos
feat: agregar comando de backup automático
fix: corregir error en detección de proyectos TypeScript
docs: actualizar guía de instalación
refactor: simplificar lógica de auto-detección
test: agregar tests para sistema de guardado
chore: actualizar dependencias de desarrollo
```

## 🧪 Testing

### Escribir Tests

```typescript
// tests/unit/memory-server.test.ts
import { describe, it, expect, beforeEach } from 'vitest';
import { MemoryServer } from '../src/server/memory-server';

describe('MemoryServer', () => {
  let memoryServer: MemoryServer;

  beforeEach(() => {
    memoryServer = new MemoryServer();
  });

  it('should save memory correctly', async () => {
    const testData = { test: 'data' };
    
    await memoryServer.saveMemory('test-key', testData);
    const retrieved = await memoryServer.getMemory('test-key');
    
    expect(retrieved).toEqual(testData);
  });

  it('should handle non-existent keys', async () => {
    const result = await memoryServer.getMemory('non-existent');
    expect(result).toBeNull();
  });
});
```

### Ejecutar Tests

```bash
# Todos los tests
npm test

# Tests específicos
npm test -- --grep "MemoryServer"

# Coverage
npm run test:coverage

# Tests en modo watch
npm run test:watch
```

## 📝 Documentación

### Documentar Código

```typescript
/**
 * Guarda datos en el sistema de memoria persistente
 * @param key - Clave única para identificar los datos
 * @param data - Datos a guardar (serializables en JSON)
 * @returns Promise que resuelve cuando los datos se han guardado
 * @throws {MemoryError} Si hay problemas de escritura en disco
 * 
 * @example
 * ```typescript
 * await saveMemory('session-123', { 
 *   temas: ['MCP', 'TypeScript'],
 *   fecha: new Date()
 * });
 * ```
 */
async saveMemory(key: string, data: MemoryData): Promise<void> {
  // implementación
}
```

### Actualizar Documentación

Siempre actualiza la documentación cuando:
- Agregas nuevas funcionalidades
- Cambias comportamiento existente
- Corriges errores en la documentación actual
- Agregas nuevos comandos o opciones

## 🚀 Release Process

### Versionado

Seguimos [Semantic Versioning](https://semver.org/):

- **MAJOR** (1.0.0): Cambios incompatibles
- **MINOR** (0.1.0): Nueva funcionalidad compatible
- **PATCH** (0.0.1): Bug fixes compatibles

### Preparar Release

```bash
# 1. Asegurar que main está actualizado
git checkout main
git pull origin main

# 2. Crear branch de release
git checkout -b release/v1.1.0

# 3. Actualizar version en package.json
npm version minor

# 4. Actualizar CHANGELOG.md
# 5. Commit cambios
git commit -am "chore: prepare release v1.1.0"

# 6. Crear PR a main
# 7. Después de merge, crear tag
git tag v1.1.0
git push origin v1.1.0
```

## ❓ ¿Preguntas?

Si tienes preguntas sobre contribuir:

1. **Revisa** la documentación existente
2. **Busca** en issues cerrados
3. **Abre** un issue con la etiqueta "question"
4. **Contacta** a los mantenedores

## 🙏 Reconocimientos

¡Gracias por contribuir al MCP Memory System! Cada contribución hace que el proyecto sea mejor para todos.

### Contribuidores Principales

- **Manuel Fernández del Real** - Creador y mantenedor principal
- **[Tu Nombre Aquí]** - ¡Convierte en contribuidor!

### Cómo Aparecerás

Los contribuidores aparecen automáticamente en:
- README principal
- Página de releases
- All Contributors bot (próximamente)

¡Esperamos tus contribuciones! 🚀✨
