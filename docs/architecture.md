# 🏗️ Architecture

Comprehensive architecture documentation for projects generated with the Data Architect Template.

---

## 📚 Table of Contents

- [System Overview](#system-overview)
- [Core Principles](#core-principles)
- [Component Architecture](#component-architecture)
- [Data Flow](#data-flow)
- [Technology Decisions](#technology-decisions)
- [Scalability Strategy](#scalability-strategy)
- [Security Architecture](#security-architecture)

---

## System Overview

### High-Level Architecture

The template generates a **modular monolith by default** (Community Mode) with **microservices-ready architecture** (Enterprise Mode).

```
┌─────────────────────────────────────┐
│         Users (Web/Mobile/API)          │
└───────────────┬──────────────────────┘
                │
    ┌───────────▼────────────┐
    │    API Gateway / LB      │
    │   (Nginx/Traefik)       │
    └─────────┬───────────────┘
              │
    ┌─────────▼─────────────────┐
    │    Application Layer        │
    ├───────────────────────────┤
    │  • Web UI (React/Vue)      │
    │  • REST API (Fastify)      │
    │  • WebSocket (Socket.io)   │
    │  • GraphQL (optional)      │
    └─────────┬─────────────────┘
              │
    ┌─────────▼─────────────────┐
    │  Orchestration Engine     │
    ├───────────────────────────┤
    │  • Workflow Manager       │
    │  • Agent Coordinator      │
    │  • Confidence Router      │
    │  • Validation Queue       │
    └─────────┬─────────────────┘
              │
    ┌─────────▼─────────────────┐
    │     Worker Pool           │
    ├───────────────────────────┤
    │  • AI Agents (5+)         │
    │  • Connectors (10+)       │
    │  • Sandbox Execution      │
    └─────────┬─────────────────┘
              │
    ┌─────────▼─────────────────┐
    │   Message Queue (Redis)    │
    ├───────────────────────────┤
    │  • BullMQ Jobs            │
    │  • Pub/Sub Events         │
    │  • Session Store          │
    └─────────┬─────────────────┘
              │
    ┌─────────▼─────────────────┐
    │  Database (PostgreSQL)    │
    ├───────────────────────────┤
    │  • Relational Data        │
    │  • Vector Search (pgvector)│
    │  • Full-Text Search       │
    └───────────────────────────┘

   ┌───────────────────────────┐
   │  External Integrations   │
   ├───────────────────────────┤
   │  • LLM APIs (OpenAI, etc.)│
   │  • Storage (S3, Drive)    │
   │  • Email (SMTP, APIs)     │
   │  • Monitoring (Prometheus)│
   └───────────────────────────┘
```

---

## Core Principles

### 1. Single-Tenant by Default, Multi-Tenant Ready

**Philosophy:** Start simple, scale when needed.

**Community Mode (Default):**

```typescript
// Simple, no tenant_id everywhere
const workflows = await db.workflow.findMany();
```

**Enterprise Mode (Enabled via `MULTI_TENANT=true`):**

```typescript
// Automatic tenant isolation
const workflows = await db.workflow.findMany({
  where: { tenantId: currentTenant }
});
```

**Migration Path:**

```sql
-- Add tenant_id column when ready
ALTER TABLE workflows ADD COLUMN tenant_id UUID REFERENCES tenants(id);
CREATE INDEX idx_workflows_tenant ON workflows(tenant_id);
```

**Key Benefits:**

✅ Community users don't pay overhead cost
✅ Enterprise migration is seamless
✅ Code stays clean and readable

---

### 2. pgvector as First-Class Citizen

**Why pgvector?**

- ✅ **Native PostgreSQL extension** (no separate service)
- ✅ **Semantic search** for RAG and long-term memory
- ✅ **Cosine similarity** for intelligent matching
- ✅ **HNSW indexing** for fast approximate search

**Use Cases:**

1. **RAG Documentation** → Chatbot searches docs semantically
2. **Deduplication** → Finds similar items even with different names
3. **Auto-Classification** → Matches new items to existing categories
4. **Agent Memory** → Long-term context retention

**Architecture:**

```sql
CREATE TABLE embeddings (
  id UUID PRIMARY KEY,
  content TEXT NOT NULL,
  embedding vector(384), -- or 768, 1536 depending on model
  provider TEXT, -- 'local' | 'openai'
  model TEXT,
  metadata JSONB,
  created_at TIMESTAMP
);

CREATE INDEX ON embeddings USING hnsw (embedding vector_cosine_ops);
```

---

### 3. Human-in-the-Loop (HITL) by Design

**Core Concept:** AI suggests, humans decide (when uncertain).

**Confidence-Based Routing:**

```typescript
if (confidence >= 90) {
  // Auto-execute
  await executeAction(action);
} else if (confidence >= 70) {
  // Auto-execute but notify
  await executeAction(action);
  await notifyUser('Action executed with medium confidence');
} else {
  // Queue for human validation
  await validationQueue.add({
    action,
    confidence,
    preview: generatePreview(action)
  });
}
```

**Validation Interface:**

- **Swipe Right** → Approve
- **Swipe Left** → Reject
- **Swipe Up** → See Details

**Learning Loop:**

1. User validates action
2. System stores feedback
3. Future confidence scores improve
4. Fewer validations over time

---

### 4. Security-First Sandbox Execution

**Problem:** Running user-generated or LLM-generated code is dangerous.

**Solution:** Multi-layer sandbox with auto-detection.

**Priority Order:**

1. **WASM** (fastest, most secure) → Simple scripts
2. **Firecracker microVMs** (Linux KVM) → Complex workloads
3. **Docker** (fallback) → Last resort

**Auto-Detection:**

```typescript
function selectSandbox(): SandboxType {
  if (process.env.SANDBOX_TYPE !== 'auto') {
    return process.env.SANDBOX_TYPE;
  }
  
  // Linux + KVM available?
  if (isLinux() && hasKVM()) return 'firecracker';
  
  // WASM available (all OS)
  if (wasmtimeInstalled()) return 'wasm';
  
  // Fallback
  return 'docker';
}
```

---

## Component Architecture

### Backend Components

#### 1. API Layer

**Responsibilities:**

- HTTP request handling
- Authentication & authorization
- Input validation (Zod schemas)
- Response formatting
- Rate limiting

**Stack:**

- **Framework:** Fastify (default) | Express | Hono
- **Validation:** Zod
- **Auth:** JWT + refresh tokens
- **Docs:** OpenAPI 3.0 (auto-generated)

#### 2. Orchestration Engine

**Responsibilities:**

- Workflow execution planning
- DAG (Directed Acyclic Graph) resolution
- Parallel/sequential task scheduling
- Retry logic with exponential backoff
- Confidence-based routing

**Key Classes:**

```typescript
class WorkflowOrchestrator {
  async execute(workflowId: string): Promise<WorkflowResult> {
    const workflow = await this.loadWorkflow(workflowId);
    const dag = this.buildDAG(workflow);
    const executionPlan = this.optimizeDAG(dag);
    
    for (const step of executionPlan) {
      const result = await this.executeStep(step);
      
      if (result.confidence < threshold) {
        await validationQueue.add(result);
      }
    }
    
    return this.collectResults();
  }
}
```

#### 3. Worker Pool

**Responsibilities:**

- Agent execution
- Connector communication
- Sandbox management
- Resource limits enforcement

**Architecture:**

```typescript
class WorkerPool {
  workers: Worker[];
  queue: BullQueue;
  
  async processJob(job: Job) {
    const sandbox = selectSandbox(job.type);
    const agent = await this.loadAgent(job.agentId);
    
    return sandbox.execute({
      code: agent.code,
      input: job.input,
      timeout: job.timeout || 30000,
      memory: job.memory || '256MB'
    });
  }
}
```

---

### Frontend Components

#### 1. Design System

**Core Principles:**

- **Atomic Design** (atoms → molecules → organisms)
- **Dark/Light Mode** with smooth transitions
- **Responsive** (mobile-first)
- **Accessible** (WCAG 2.1 AA)

**Component Library:**

```
src/components/
├── atoms/
│   ├── Button.tsx
│   ├── Input.tsx
│   └── Badge.tsx
├── molecules/
│   ├── Card.tsx
│   ├── Form.tsx
│   └── Modal.tsx
└── organisms/
    ├── Dashboard.tsx
    ├── WorkflowEditor.tsx
    └── ValidationQueue.tsx
```

#### 2. State Management

**Global State (Zustand):**

```typescript
interface AppState {
  user: User | null;
  workflows: Workflow[];
  validationQueue: ValidationTask[];
  theme: 'light' | 'dark';
  
  // Actions
  login: (credentials: Credentials) => Promise<void>;
  fetchWorkflows: () => Promise<void>;
  approveTask: (taskId: string) => Promise<void>;
}
```

**Server State (TanStack Query):**

```typescript
// Automatic caching + optimistic updates
const { data, isLoading } = useQuery({
  queryKey: ['workflows'],
  queryFn: fetchWorkflows,
  staleTime: 5000
});

const mutation = useMutation({
  mutationFn: approveTask,
  onSuccess: () => {
    queryClient.invalidateQueries(['validationQueue']);
  }
});
```

---

## Data Flow

### Workflow Execution Flow

```
1. User triggers workflow
   ↓
2. API validates request
   ↓
3. Orchestrator builds DAG
   ↓
4. Job added to BullMQ queue
   ↓
5. Worker picks job
   ↓
6. Agent executes in sandbox
   ↓
7. Confidence score calculated
   ↓
8. Routing decision:
   ├────> High confidence? → Auto-execute
   ├────> Medium? → Execute + Notify
   └────> Low? → Validation Queue
   ↓
9. Result stored in DB
   ↓
10. WebSocket notifies UI
   ↓
11. User sees result/validation card
```

### Human Validation Flow

```
1. Low-confidence task queued
   ↓
2. UI shows validation card
   │
   ├──> Swipe Right (Approve)
   │     ↓
   │     Execute action
   │     ↓
   │     Store positive feedback
   │     ↓
   │     Improve future confidence
   │
   └──> Swipe Left (Reject)
         ↓
         Cancel action
         ↓
         Store negative feedback
         ↓
         Learn from rejection
```

---

## Technology Decisions

### ADR-001: Why Fastify over Express?

**Decision:** Use Fastify as default backend framework.

**Rationale:**

✅ **Performance:** 2-3x faster than Express
✅ **Type Safety:** Built-in TypeScript support
✅ **Schema Validation:** JSON Schema out of the box
✅ **Plugin Ecosystem:** Clean plugin architecture
✅ **Async/Await:** First-class async support

**Alternatives Considered:**

- **Express:** More mature, larger ecosystem (but slower)
- **Hono:** Edge-ready, ultra-fast (but less mature)

**Trade-offs:**

⚠️ Smaller community than Express
⚠️ Some plugins not available

---

### ADR-002: Why pgvector over Separate Vector DB?

**Decision:** Use pgvector extension for vector search.

**Rationale:**

✅ **Single Database:** No extra service to manage
✅ **ACID Transactions:** Vectors + metadata in one transaction
✅ **Cost:** No additional infrastructure
✅ **Simplicity:** One connection pool, one backup strategy

**Alternatives Considered:**

- **Pinecone:** Managed vector DB (but costs $$$)
- **Weaviate:** Powerful but complex setup
- **Milvus:** Great performance but heavy

**Trade-offs:**

⚠️ Slightly slower than specialized vector DBs
⚠️ Limited to PostgreSQL ecosystem

---

### ADR-003: Why WASM over Docker for Sandboxing?

**Decision:** Prioritize WASM > Firecracker > Docker.

**Rationale:**

**WASM:**
✅ Ultra-fast startup (<1ms)
✅ Strong security boundaries
✅ Cross-platform (Windows, Linux, macOS)
✅ Minimal overhead

**Firecracker:**
✅ Full Linux VMs with microVM speed
✅ Kernel-level isolation
❌ Linux + KVM only

**Docker:**
⚠️ Heavy (seconds to start)
⚠️ Docker-in-Docker issues
✅ Fallback for compatibility

**Trade-offs:**

⚠️ WASM limited to supported languages
⚠️ Firecracker Linux-only

---

## Scalability Strategy

### Horizontal Scaling

**Stateless Services:**

All application logic is stateless → easy to replicate.

```yaml
# Docker Compose scaling
docker-compose up --scale worker=5
```

**Load Balancing:**

```nginx
upstream backend {
  least_conn;
  server app1:3000;
  server app2:3000;
  server app3:3000;
}
```

### Database Scaling

**Read Replicas:**

```typescript
const db = new Prisma({
  datasources: {
    db: {
      url: env.DATABASE_URL, // Write
    },
    dbRead: {
      url: env.DATABASE_READ_URL, // Read replica
    }
  }
});
```

**Connection Pooling:**

```yaml
# PgBouncer configuration
default_pool_size = 25
max_client_conn = 1000
pool_mode = transaction
```

---

## Security Architecture

### Defense in Depth

**Layer 1: Network**

- TLS 1.3 for all connections
- Rate limiting (Redis sliding window)
- IP whitelisting (optional)
- DDoS protection (Cloudflare)

**Layer 2: Application**

- Input validation (Zod schemas)
- SQL injection protection (ORM prepared statements)
- XSS prevention (sanitization + CSP)
- CSRF tokens

**Layer 3: Authentication**

- JWT with short expiry (15min)
- Refresh tokens (httpOnly cookies)
- 2FA optional (TOTP)
- OAuth2 (Google, GitHub)

**Layer 4: Authorization**

- RBAC (Role-Based Access Control)
- Permission checks at API + DB level
- Audit trail (who/what/when)

**Layer 5: Data**

- Encryption at rest (AES-256)
- Encryption in transit (TLS 1.3)
- Secrets management (Vault or encrypted files)

**Layer 6: Execution**

- Sandbox isolation (WASM/Firecracker/Docker)
- Resource limits (CPU, memory, timeout)
- Network isolation (no internet access)

---

**Next:** [Customization Guide](customization-guide.md) →