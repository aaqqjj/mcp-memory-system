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
import type {
  ProjectContext,
  SaveMemoryArgs,
  GetMemoryArgs,
  SaveSessionArgs,
  SearchMemoryArgs,
  MemoryItem,
  FeatureStatus
} from './types.js';

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
    const initialContext: ProjectContext = {
      project: {
        name: 'perito-forense-web',
        status: 'production-ready',
        lastUpdate: new Date().toISOString(),
        branch: 'feature/website-improvements'
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
        ]
      }
    };

    await fs.writeFile(this.contextPath, JSON.stringify(initialContext, null, 2));
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
          },
          {
            uri: 'memory://sessions',
            name: 'Session History',
            description: 'Historial de sesiones de trabajo',
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
        
        case 'memory://sessions':
          return {
            contents: [{
              uri: request.params.uri,
              mimeType: 'application/json',
              text: JSON.stringify(context.sessions, null, 2)
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
          return await this.saveMemory(args as unknown as SaveMemoryArgs);
        
        case 'get_memory':
          return await this.getMemory(args as unknown as GetMemoryArgs);
        
        case 'get_project_status':
          return await this.getProjectStatus();
        
        case 'save_session':
          return await this.saveSession(args as unknown as SaveSessionArgs);
        
        case 'search_memory':
          return await this.searchMemory(args as unknown as SearchMemoryArgs);
        
        default:
          throw new McpError(ErrorCode.MethodNotFound, `Herramienta no encontrada: ${name}`);
      }
    });
  }

  private async loadContext(): Promise<ProjectContext> {
    const data = await fs.readFile(this.contextPath, 'utf8');
    return JSON.parse(data);
  }

  private async saveContext(context: ProjectContext) {
    await fs.writeFile(this.contextPath, JSON.stringify(context, null, 2));
  }

  private async saveMemory(args: SaveMemoryArgs) {
    const context = await this.loadContext();
    
    if (!context.memory.data) {
      context.memory.data = {};
    }
    
    context.memory.data[args.key] = {
      value: args.value,
      category: args.category,
      timestamp: new Date().toISOString()
    };
    
    await this.saveContext(context);
    
    return {
      content: [{
        type: 'text',
        text: `✅ Información guardada en memoria:\nClave: ${args.key}\nCategoría: ${args.category}\nValor: ${args.value}`
      }]
    };
  }

  private async getMemory(args: GetMemoryArgs) {
    const context = await this.loadContext();
    const data = context.memory.data || {};
    
    if (args.key) {
      const item = data[args.key];
      if (!item) {
        return {
          content: [{
            type: 'text',
            text: `❌ No se encontró información para la clave: ${args.key}`
          }]
        };
      }
      
      return {
        content: [{
          type: 'text',
          text: `📋 **${args.key}** (${item.category})\n${item.value}\n\n⏰ Guardado: ${new Date(item.timestamp).toLocaleString()}`
        }]
      };
    }
    
    if (args.category) {
      const filtered = Object.entries(data)
        .filter(([_, item]: [string, MemoryItem]) => item.category === args.category);
      
      if (filtered.length === 0) {
        return {
          content: [{
            type: 'text',
            text: `❌ No se encontró información en la categoría: ${args.category}`
          }]
        };
      }
      
      const result = filtered.map(([key, item]: [string, MemoryItem]) => 
        `📋 **${key}**: ${item.value}`
      ).join('\n\n');
      
      return {
        content: [{
          type: 'text',
          text: `🗂️ **Categoría: ${args.category}**\n\n${result}`
        }]
      };
    }
    
    // Devolver toda la memoria
    const allItems = Object.entries(data)
      .map(([key, item]: [string, MemoryItem]) => 
        `📋 **${key}** (${item.category}): ${item.value}`
      ).join('\n\n');
    
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
${Object.entries(context.features).map(([key, feature]: [string, FeatureStatus]) => 
  `• **${key}**: ${feature.status} (${feature.coverage || feature.optimized || 'completo'})`
).join('\n')}

🧠 **Puntos Clave**:
${context.memory.keyPoints.map((point: string) => `• ${point}`).join('\n')}

🎯 **Foco Actual**: ${context.memory.currentFocus}

🔄 **Próximos Pasos**:
${context.memory.nextSteps.map((step: string) => `• ${step}`).join('\n')}

📈 **Sesiones**: ${context.sessions.length} sesiones registradas`
      }]
    };
  }

  private async saveSession(args: SaveSessionArgs) {
    const context = await this.loadContext();
    
    const session = {
      id: Date.now(),
      timestamp: new Date().toISOString(),
      summary: args.summary,
      achievements: args.achievements || [],
      nextActions: args.nextActions || []
    };
    
    context.sessions.push(session);
    context.project.lastUpdate = session.timestamp;
    
    await this.saveContext(context);
    
    return {
      content: [{
        type: 'text',
        text: `✅ **Sesión Guardada**

📝 **Resumen**: ${args.summary}

🏆 **Logros**:
${(args.achievements || []).map(a => `• ${a}`).join('\n') || '• Sin logros específicos registrados'}

🔄 **Próximas Acciones**:
${(args.nextActions || []).map(a => `• ${a}`).join('\n') || '• Sin acciones específicas definidas'}

🆔 **ID de Sesión**: ${session.id}`
      }]
    };
  }

  private async searchMemory(args: SearchMemoryArgs) {
    const context = await this.loadContext();
    const data = context.memory.data || {};
    const query = args.query.toLowerCase();
    
    const results = Object.entries(data)
      .filter(([key, item]: [string, MemoryItem]) => 
        key.toLowerCase().includes(query) || 
        item.value.toLowerCase().includes(query) ||
        item.category.toLowerCase().includes(query)
      );
    
    if (results.length === 0) {
      return {
        content: [{
          type: 'text',
          text: `❌ No se encontraron resultados para: "${args.query}"`
        }]
      };
    }
    
    const resultText = results.map(([key, item]: [string, MemoryItem]) => 
      `📋 **${key}** (${item.category})\n${item.value}\n⏰ ${new Date(item.timestamp).toLocaleString()}`
    ).join('\n\n---\n\n');
    
    return {
      content: [{
        type: 'text',
        text: `🔍 **Resultados para "${args.query}"** (${results.length} encontrados)\n\n${resultText}`
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
