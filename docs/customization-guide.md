# 🔧 Customization Guide

> How to extend and customize your generated project

---

## 📚 Table of Contents

- [Design System](#design-system)
- [Adding Custom Agents](#adding-custom-agents)
- [Creating Connectors](#creating-connectors)
- [Building Plugins](#building-plugins)
- [Extending the API](#extending-the-api)
- [Custom UI Components](#custom-ui-components)
- [Database Customization](#database-customization)

---

## Design System

### Changing Colors

**1. Update CSS Variables**

Edit `src/styles/design-system.css`:

```css
:root {
  /* Change primary brand color */
  --color-primary: #0066CC; /* Your brand color */
  --color-primary-hover: #0052A3;
  --color-primary-active: #003D7A;
  
  /* Change background */
  --color-background: #FFFFFF;
  --color-surface: #F8F9FA;
}

/* Dark mode */
@media (prefers-color-scheme: dark) {
  :root {
    --color-primary: #3B9EFF; /* Lighter for dark bg */
    --color-background: #1A1A1A;
    --color-surface: #2A2A2A;
  }
}
```

**2. Test in Both Modes**

```bash
# Force light mode
open http://localhost:3000?theme=light

# Force dark mode
open http://localhost:3000?theme=dark
```

---

### Custom Fonts

**Add Google Fonts:**

In `index.html`:

```html
<head>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
```

Update CSS:

```css
:root {
  --font-family-base: 'Inter', -apple-system, sans-serif;
}
```

---

## Adding Custom Agents

### Agent Structure

```typescript
// src/agents/MyCustomAgent.ts

import { BaseAgent, AgentConfig, AgentResult } from './BaseAgent';

export interface MyAgentConfig extends AgentConfig {
  customSetting: string;
  threshold: number;
}

export class MyCustomAgent extends BaseAgent<MyAgentConfig> {
  async execute(input: any): Promise<AgentResult> {
    // 1. Validate input
    const validated = this.validateInput(input);
    
    // 2. Perform your logic
    const result = await this.processData(validated);
    
    // 3. Calculate confidence
    const confidence = this.calculateConfidence(result);
    
    // 4. Return standardized result
    return {
      status: confidence > this.config.threshold ? 'completed' : 'pending_validation',
      confidence,
      data: result,
      metadata: {
        agentId: this.id,
        timestamp: new Date().toISOString()
      }
    };
  }
  
  private async processData(data: any): Promise<any> {
    // Your custom logic here
    return data;
  }
  
  private calculateConfidence(result: any): number {
    // Your confidence scoring logic
    return 85;
  }
}
```

### Register Agent

```typescript
// src/agents/registry.ts

import { MyCustomAgent } from './MyCustomAgent';

export const agentRegistry = {
  'my-custom-agent': MyCustomAgent,
  'file-triage': FileTr iageAgent,
  // ... other agents
};
```

### Test Agent

```typescript
// src/agents/__tests__/MyCustomAgent.test.ts

import { MyCustomAgent } from '../MyCustomAgent';

describe('MyCustomAgent', () => {
  it('should execute successfully with high confidence', async () => {
    const agent = new MyCustomAgent({
      id: 'test-agent',
      customSetting: 'value',
      threshold: 80
    });
    
    const result = await agent.execute({ test: 'data' });
    
    expect(result.status).toBe('completed');
    expect(result.confidence).toBeGreaterThan(80);
  });
});
```

---

## Creating Connectors

### Connector Template

```typescript
// src/connectors/MyAPIConnector.ts

import { BaseConnector, ConnectorConfig } from './BaseConnector';

export interface MyAPIConfig extends ConnectorConfig {
  apiKey: string;
  apiUrl: string;
  timeout?: number;
}

export class MyAPIConnector extends BaseConnector<MyAPIConfig> {
  private client: any;
  
  async connect(): Promise<void> {
    this.client = createClient({
      apiKey: this.config.apiKey,
      baseURL: this.config.apiUrl
    });
    
    // Test connection
    await this.client.ping();
    this.connected = true;
  }
  
  async disconnect(): Promise<void> {
    this.client = null;
    this.connected = false;
  }
  
  async fetch(params: any): Promise<any> {
    if (!this.connected) {
      await this.connect();
    }
    
    return this.client.get('/endpoint', params);
  }
  
  async create(data: any): Promise<any> {
    return this.client.post('/endpoint', data);
  }
}
```

### Add to Registry

```typescript
// src/connectors/registry.ts

import { MyAPIConnector } from './MyAPIConnector';

export const connectorRegistry = {
  'my-api': MyAPIConnector,
  'gmail': GmailConnector,
  's3': S3Connector,
  // ...
};
```

---

## Building Plugins

### Plugin Structure

```typescript
// plugins/my-plugin/index.ts

import { Plugin, PluginConfig } from '../../src/types/plugin';

export const myPlugin: Plugin = {
  id: 'my-plugin',
  name: 'My Awesome Plugin',
  version: '1.0.0',
  description: 'Does awesome things',
  author: 'Your Name',
  
  // Lifecycle hooks
  async onInstall() {
    console.log('Plugin installed');
  },
  
  async onEnable() {
    console.log('Plugin enabled');
  },
  
  // Create custom agent
  createAgent(config) {
    return new MyPluginAgent(config);
  },
  
  // Add UI component
  configUI: ({ value, onChange }) => (
    <div>
      <label>Plugin Setting</label>
      <input 
        value={value.setting}
        onChange={(e) => onChange({ ...value, setting: e.target.value })}
      />
    </div>
  ),
  
  // Register API routes
  registerRoutes(server) {
    server.get('/api/plugin/my-endpoint', async (req, reply) => {
      return { data: 'from plugin' };
    });
  }
};
```

### Install Plugin

```bash
# Add to plugins directory
cp -r my-plugin/ plugins/

# Install via UI
Navigate to Settings → Plugins → Install from Folder

# Or via API
curl -X POST http://localhost:3000/api/v1/plugins/install \
  -d '{ "path": "./plugins/my-plugin" }'
```

---

## Extending the API

### Add New Endpoint

```typescript
// src/routes/custom.ts

import { FastifyInstance } from 'fastify';
import { z } from 'zod';

const requestSchema = z.object({
  name: z.string(),
  value: z.number()
});

export async function customRoutes(server: FastifyInstance) {
  server.post('/api/v1/custom', {
    schema: {
      body: requestSchema,
      response: {
        200: z.object({
          success: z.boolean(),
          data: z.any()
        })
      }
    },
    handler: async (request, reply) => {
      const { name, value } = request.body;
      
      // Your logic here
      const result = await processCustomLogic(name, value);
      
      return {
        success: true,
        data: result
      };
    }
  });
}
```

### Register Routes

```typescript
// src/server.ts

import { customRoutes } from './routes/custom';

server.register(customRoutes);
```

---

## Custom UI Components

### Create Component

```typescript
// src/components/organisms/MyDashboard.tsx

import { Card, Button } from '../molecules';
import { useQuery } from '@tanstack/react-query';

export function MyDashboard() {
  const { data, isLoading } = useQuery({
    queryKey: ['my-data'],
    queryFn: fetchMyData
  });
  
  if (isLoading) return <Spinner />;
  
  return (
    <div className="grid grid-cols-2 gap-4">
      <Card title="Metric 1">
        <p className="text-4xl font-bold">{data.metric1}</p>
      </Card>
      
      <Card title="Metric 2">
        <p className="text-4xl font-bold">{data.metric2}</p>
      </Card>
      
      <Button onClick={handleAction}>
        Perform Action
      </Button>
    </div>
  );
}
```

### Add to Navigation

```typescript
// src/App.tsx

import { MyDashboard } from './components/organisms/MyDashboard';

const routes = [
  { path: '/', component: Dashboard },
  { path: '/workflows', component: Workflows },
  { path: '/my-dashboard', component: MyDashboard }, // New route
];
```

---

## Database Customization

### Add New Table

```prisma
// prisma/schema.prisma

model CustomEntity {
  id          String   @id @default(uuid())
  name        String
  description String?
  metadata    Json?
  embedding   Unsupported("vector(384)")? // pgvector
  
  createdAt   DateTime @default(now())
  updatedAt   DateTime @updatedAt
  
  // Relations
  userId      String
  user        User     @relation(fields: [userId], references: [id])
  
  @@index([userId])
  @@index([embedding(ops: vector_cosine_ops)]) // Vector index
}

model User {
  // ...
  customEntities CustomEntity[]
}
```

### Run Migration

```bash
# Create migration
npm run prisma:migrate -- dev --name add-custom-entity

# Apply migration
npm run prisma:migrate -- deploy

# Regenerate client
npm run prisma:generate
```

### Query with Vector Search

```typescript
import { db } from './db';

const similar = await db.$queryRaw`
  SELECT 
    id,
    name,
    1 - (embedding <=> ${queryEmbedding}::vector) AS similarity
  FROM "CustomEntity"
  WHERE 1 - (embedding <=> ${queryEmbedding}::vector) > 0.7
  ORDER BY embedding <=> ${queryEmbedding}::vector
  LIMIT 10
`;
```

---

## Best Practices

### Code Organization

```
src/
├── agents/           # AI agents
│   ├── __tests__/
│   ├── BaseAgent.ts
│   └── [YourAgent].ts
├── connectors/      # External integrations
├── components/      # UI components (atomic design)
├── routes/          # API endpoints
├── services/        # Business logic
├── utils/           # Helper functions
└── types/           # TypeScript types
```

### Testing

```typescript
// Always write tests for custom code
import { describe, it, expect } from 'vitest';

describe('MyCustomFeature', () => {
  it('should work correctly', async () => {
    const result = await myFeature.execute();
    expect(result).toBeDefined();
  });
});
```

### Documentation

```typescript
/**
 * Brief description of what this does.
 * 
 * @param input - What the input is
 * @returns What is returned
 * @throws When it throws errors
 * 
 * @example
 * const result = await myFunction({ data: 'test' });
 */
export async function myFunction(input: Input): Promise<Output> {
  // ...
}
```

---

## Need Help?

- 📚 [Architecture Guide](architecture.md)
- ❓ [FAQ](faq.md)
- 🐞 [Report Issues](https://github.com/Krigsexe/Data-Architect-Template/issues)

---

**Happy customizing!** 🎨