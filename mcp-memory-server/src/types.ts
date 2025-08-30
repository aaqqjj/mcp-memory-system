// 🧠 **Tipos para el MCP Memory Server**

export interface ProjectContext {
  project: {
    name: string;
    status: string;
    lastUpdate: string;
    branch: string;
  };
  features: Record<string, FeatureStatus>;
  sessions: SessionRecord[];
  memory: {
    keyPoints: string[];
    currentFocus: string;
    nextSteps: string[];
    data?: Record<string, MemoryItem>;
  };
}

export interface FeatureStatus {
  status: 'completed' | 'in-progress' | 'planned';
  coverage?: string;
  optimized?: boolean;
  dynamic?: boolean;
  automation?: string;
}

export interface MemoryItem {
  value: string;
  category: 'feature' | 'bug' | 'task' | 'note' | 'config';
  timestamp: string;
}

export interface SessionRecord {
  id: number;
  timestamp: string;
  summary: string;
  achievements: string[];
  nextActions: string[];
}

export interface SaveMemoryArgs {
  key: string;
  value: string;
  category: 'feature' | 'bug' | 'task' | 'note' | 'config';
}

export interface GetMemoryArgs {
  key?: string;
  category?: string;
}

export interface SaveSessionArgs {
  summary: string;
  achievements?: string[];
  nextActions?: string[];
}

export interface SearchMemoryArgs {
  query: string;
}
