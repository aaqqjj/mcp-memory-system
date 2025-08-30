#!/usr/bin/env node

import { Server } from '@modelcontextprotocol/sdk/server/index.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';
import {
  CallToolRequestSchema,
  ErrorCode,
  ListResourcesRequestSchema,
  ListToolsRequestSchema,
  McpError,
  ReadResourceRequestSchema,
} from '@modelcontextprotocol/sdk/types.js';
import { promises as fs } from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// 🧠 **MCP Server para Memoria Persistente del Proyecto Perito Forense**
class PeritoForenseMemoryServer {
  private server: Server;
  private memoryPath: string;
  private contextPath: string;
  private projectRoot: string;

  constructor() {
    this.projectRoot = path.resolve(__dirname, '../../');
    this.memoryPath = path.join(this.projectRoot, '.mcp-memory');
    this.contextPath = path.join(this.memoryPath, 'context.json');
    
    this.server = new Server(
      {
        name: 'perito-forense-memory',
        version: '1.0.0',
      },
      {
        capabilities: {
          resources: {},
          tools: {},
        },
      }
    );

    this.setupMemoryDirectory();
    this.setupHandlers();
  }

  private async setupMemoryDirectory() {
    try {
      await fs.mkdir(this.memoryPath, { recursive: true });
    } catch {
      // Directorio ya existe
    }
    
    // Inicializar contexto si no existe
    try {
      await fs.access(this.contextPath);
    } catch {
      await this.initializeContext();
    }
  }

  private async initializeContext() {
    const projectName = await this.detectProjectName();
    const initialContext = {
      project: {
        name: projectName,
        status: 'initializing',
        lastUpdate: new Date().toISOString(),
        directory: process.cwd()
      },
      features: {
        seo: { status: 'completed', coverage: '100%' },
        ogImages: { status: 'completed', optimized: true },
        sitemap: { status: 'completed', dynamic: true },
        scripts: { status: 'completed', automation: '100%' }
      },
      sessions: [],
      memory: {
        keyPoints: [
          'Sistema SEO completo implementado y funcionando',
          'Imágenes OG optimizadas en WebP (<25KB)',
          'Sitemap dinámico configurado', 
          'Scripts de automatización listos',
          'Sistema de context recovery implementado'
        ],
        currentFocus: 'Optimización SEO y imágenes sociales completada',
        nextSteps: [
          'Completar imágenes OG para páginas restantes',
          'Testing en producción',
          'Integración con Google Analytics'
        ],
        data: {}
      }
    };

    await fs.writeFile(this.contextPath, JSON.stringify(initialContext, null, 2));
  }

  // Auto-detectar nombre del proyecto
  private async detectProjectName(): Promise<string> {
    try {
      // Intentar leer package.json
      const packageJsonPath = path.join(process.cwd(), 'package.json');
      if (await fs.access(packageJsonPath).then(() => true).catch(() => false)) {
        const packageJson = JSON.parse(await fs.readFile(packageJsonPath, 'utf-8'));
        if (packageJson.name) {
          return packageJson.name;
        }
      }
      
      // Fallback: usar nombre del directorio actual
      const currentDir = path.basename(process.cwd());
      return currentDir || 'proyecto-sin-nombre';
    } catch {
      return 'proyecto-sin-nombre';
    }
  }

  private setupHandlers() {
    // **Lista de herramientas disponibles**
    this.server.setRequestHandler(ListToolsRequestSchema, async () => {
      return {
        tools: [
          {
            name: 'save_memory',
            description: 'Guarda información importante en la memoria persistente',
            inputSchema: {
              type: 'object',
              properties: {
                key: { type: 'string', description: 'Clave para la información' },
                value: { type: 'string', description: 'Información a guardar' },
                category: { 
                  type: 'string', 
                  enum: ['feature', 'bug', 'task', 'note', 'config'],
                  description: 'Categoría de la información' 
                }
              },
              required: ['key', 'value', 'category']
            }
          },
          {
            name: 'get_memory',
            description: 'Recupera información de la memoria persistente',
            inputSchema: {
              type: 'object',
              properties: {
                key: { type: 'string', description: 'Clave de la información a recuperar' },
                category: { type: 'string', description: 'Filtrar por categoría (opcional)' }
              }
            }
          },
          {
            name: 'get_project_status',
            description: 'Obtiene el estado completo del proyecto',
            inputSchema: {
              type: 'object',
              properties: {}
            }
          },
          {
            name: 'save_session',
            description: 'Guarda el contexto de la sesión actual',
            inputSchema: {
              type: 'object',
              properties: {
                summary: { type: 'string', description: 'Resumen de lo trabajado en la sesión' },
                achievements: { 
                  type: 'array',
                  items: { type: 'string' },
                  description: 'Logros de la sesión'
                },
                nextActions: {
                  type: 'array', 
                  items: { type: 'string' },
                  description: 'Próximas acciones sugeridas'
                }
              },
              required: ['summary']
            }
          },
          {
            name: 'search_memory',
            description: 'Busca información en la memoria persistente',
            inputSchema: {
              type: 'object',
              properties: {
                query: { type: 'string', description: 'Término de búsqueda' }
              },
              required: ['query']
            }
          }
        ]
      };
    });

    // **Lista de recursos disponibles**
    this.server.setRequestHandler(ListResourcesRequestSchema, async () => {
      return {
        resources: [
          {
            uri: 'memory://context',
            name: 'Project Context',
            description: 'Contexto completo del proyecto',
            mimeType: 'application/json'
          },
          {
            uri: 'memory://status',
            name: 'Project Status',
            description: 'Estado actual del proyecto',
            mimeType: 'application/json'
          }
        ]
      };
    });

    // **Leer recursos**
    this.server.setRequestHandler(ReadResourceRequestSchema, async (request) => {
      const context = await this.loadContext();
      
      switch (request.params.uri) {
        case 'memory://context':
          return {
            contents: [{
              uri: request.params.uri,
              mimeType: 'application/json',
              text: JSON.stringify(context, null, 2)
            }]
          };
        
        case 'memory://status':
          return {
            contents: [{
              uri: request.params.uri,
              mimeType: 'application/json',
              text: JSON.stringify({
                project: context.project,
                features: context.features,
                memory: context.memory
              }, null, 2)
            }]
          };
        
        default:
          throw new McpError(ErrorCode.InvalidRequest, `Recurso no encontrado: ${request.params.uri}`);
      }
    });

    // **Ejecutar herramientas**
    this.server.setRequestHandler(CallToolRequestSchema, async (request) => {
      const { name, arguments: args } = request.params;

      switch (name) {
        case 'save_memory':
          return await this.saveMemory(args);
        
        case 'get_memory':
          return await this.getMemory(args);
        
        case 'get_project_status':
          return await this.getProjectStatus();
        
        case 'save_session':
          return await this.saveSession(args);
        
        case 'search_memory':
          return await this.searchMemory(args);
        
        default:
          throw new McpError(ErrorCode.MethodNotFound, `Herramienta no encontrada: ${name}`);
      }
    });
  }

  private async loadContext() {
    const data = await fs.readFile(this.contextPath, 'utf8');
    return JSON.parse(data);
  }

  private async saveContext(context: object) {
    await fs.writeFile(this.contextPath, JSON.stringify(context, null, 2));
  }

  private async saveMemory(args: unknown) {
    const { key, value, category } = args as {key: string, value: string, category: string};
    const context = await this.loadContext();
    const projectName = await this.detectProjectName();
    
    if (!context.memory.data) {
      context.memory.data = {};
    }
    
    context.memory.data[key] = {
      value: value,
      category: category,
      project: projectName,
      timestamp: new Date().toISOString()
    };
    
    await this.saveContext(context);
    
    return {
      content: [{
        type: 'text',
        text: `✅ Información guardada en memoria:\nClave: ${key}\nCategoría: ${category}\nValor: ${value}`
      }]
    };
  }

  private async getMemory(args: unknown) {
    const { key, category } = args as {key?: string, category?: string};
    const context = await this.loadContext();
    const data = context.memory.data || {};
    
    if (key) {
      const item = data[key];
      if (!item) {
        return {
          content: [{
            type: 'text',
            text: `❌ No se encontró información para la clave: ${key}`
          }]
        };
      }
      
      return {
        content: [{
          type: 'text',
          text: `📋 **${key}** (${item.category})\n${item.value}\n\n⏰ Guardado: ${new Date(item.timestamp).toLocaleString()}`
        }]
      };
    }
    
    if (category) {
      const filtered = Object.entries(data)
        .filter(([_, item]: [string, unknown]) => {
          const memItem = item as {category: string, value: string};
          return memItem.category === category;
        });
      
      if (filtered.length === 0) {
        return {
          content: [{
            type: 'text',
            text: `❌ No se encontró información en la categoría: ${category}`
          }]
        };
      }
      
      const result = filtered.map(([key, item]: [string, unknown]) => {
        const memItem = item as {category: string, value: string};
        return `📋 **${key}**: ${memItem.value}`;
      }).join('\n\n');
      
      return {
        content: [{
          type: 'text',
          text: `🗂️ **Categoría: ${category}**\n\n${result}`
        }]
      };
    }
    
    // Devolver toda la memoria
    const allItems = Object.entries(data)
      .map(([key, item]: [string, unknown]) => {
        const memItem = item as {category: string, value: string};
        return `📋 **${key}** (${memItem.category}): ${memItem.value}`;
      }).join('\n\n');
    
    return {
      content: [{
        type: 'text',
        text: `🧠 **Toda la Memoria Persistente**\n\n${allItems}`
      }]
    };
  }

  private async getProjectStatus() {
    const context = await this.loadContext();
    
    return {
      content: [{
        type: 'text',
        text: `🚀 **Estado del Proyecto: ${context.project.name}**

📊 **Estado General**: ${context.project.status}
🌿 **Branch**: ${context.project.branch}
📅 **Última Actualización**: ${new Date(context.project.lastUpdate).toLocaleString()}

✅ **Características Completadas**:
${Object.entries(context.features).map(([key, feature]: [string, unknown]) => {
  const feat = feature as {status: string, coverage?: string, optimized?: boolean};
  return `• **${key}**: ${feat.status} (${feat.coverage || feat.optimized || 'completo'})`;
}).join('\n')}

🧠 **Puntos Clave**:
${context.memory.keyPoints.map((point: string) => `• ${point}`).join('\n')}

🎯 **Foco Actual**: ${context.memory.currentFocus}

🔄 **Próximos Pasos**:
${context.memory.nextSteps.map((step: string) => `• ${step}`).join('\n')}

📈 **Sesiones**: ${context.sessions.length} sesiones registradas`
      }]
    };
  }

  private async saveSession(args: unknown) {
    const { summary, achievements, nextActions } = args as {
      summary: string, 
      achievements?: string[], 
      nextActions?: string[]
    };
    
    const context = await this.loadContext();
    
    const session = {
      id: Date.now(),
      timestamp: new Date().toISOString(),
      summary: summary,
      achievements: achievements || [],
      nextActions: nextActions || []
    };
    
    context.sessions.push(session);
    context.project.lastUpdate = session.timestamp;
    
    await this.saveContext(context);
    
    return {
      content: [{
        type: 'text',
        text: `✅ **Sesión Guardada**

📝 **Resumen**: ${summary}

🏆 **Logros**:
${(achievements || []).map(a => `• ${a}`).join('\n') || '• Sin logros específicos registrados'}

🔄 **Próximas Acciones**:
${(nextActions || []).map(a => `• ${a}`).join('\n') || '• Sin acciones específicas definidas'}

🆔 **ID de Sesión**: ${session.id}`
      }]
    };
  }

  private async searchMemory(args: unknown) {
    const { query } = args as {query: string};
    const context = await this.loadContext();
    const data = context.memory.data || {};
    const queryLower = query.toLowerCase();
    
    const results = Object.entries(data)
      .filter(([key, item]: [string, unknown]) => {
        const memItem = item as {category: string, value: string};
        return key.toLowerCase().includes(queryLower) || 
               memItem.value.toLowerCase().includes(queryLower) ||
               memItem.category.toLowerCase().includes(queryLower);
      });
    
    if (results.length === 0) {
      return {
        content: [{
          type: 'text',
          text: `❌ No se encontraron resultados para: "${query}"`
        }]
      };
    }
    
    const resultText = results.map(([key, item]: [string, unknown]) => {
      const memItem = item as {category: string, value: string, timestamp: string};
      return `📋 **${key}** (${memItem.category})\n${memItem.value}\n⏰ ${new Date(memItem.timestamp).toLocaleString()}`;
    }).join('\n\n---\n\n');
    
    return {
      content: [{
        type: 'text',
        text: `🔍 **Resultados para "${query}"** (${results.length} encontrados)\n\n${resultText}`
      }]
    };
  }

  async run() {
    const transport = new StdioServerTransport();
    await this.server.connect(transport);
    console.error('🧠 Perito Forense Memory MCP Server iniciado');
  }
}

// Iniciar el servidor
const server = new PeritoForenseMemoryServer();
server.run().catch(console.error);
