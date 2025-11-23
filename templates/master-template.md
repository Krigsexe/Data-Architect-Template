# PROMPT CLAUDE CODE - MASTER TEMPLATE UNIVERSEL V2.0
## Architecture Production-Ready pour tout projet SaaS/IA

Tu es un architecte logiciel expert en systèmes agentic, IA, SaaS, sécurité, scalabilité et open source. Crée pour moi un projet logiciel complet, production-ready, auto-hébergeable nommé **[PROJECT_NAME]**.

---

## 🎯 OBJECTIF GLOBAL

Développer **[PROJECT_NAME]**, une solution [DESCRIPTION_TYPE] de [DOMAIN_DESCRIPTION], orchestrée par agents IA, configurable, sécurisée, scalable, avec UI/UX premium, déployable localement (Windows/Linux/Docker/Umbrel OS) et en Cloud.

**Exemples de remplacement :**
- `[DESCRIPTION_TYPE]` : "all-in-one" | "plateforme collaborative" | "système automatisé"
- `[DOMAIN_DESCRIPTION]` : "triage intelligent multi-domaines" | "gestion de contenu augmenté par IA" | "analyse prédictive de données"

---

## 🏗️ ARCHITECTURE FONDAMENTALE

### Principe de conception : "Single-Tenant par défaut, Multi-Tenant ready"

**⚠️ IMPORTANT : Double identité assumée**

[PROJECT_NAME] doit fonctionner dans deux modes distincts :

**Mode Community (Single-Tenant)**
- Utilisateur unique ou famille/petite équipe
- Déploiement local : Umbrel, Docker, Raspberry Pi, VPS
- Base de données simplifiée (pas de `tenant_id` partout)
- Configuration légère
- Installation one-click
- Ressources minimales : [MIN_RAM] RAM, [MIN_DISK] disk

**Mode Enterprise (Multi-Tenant ready)**
- Architecture préparée pour multi-tenant
- Isolation données par `tenant_id` (ajouté via migrations)
- SAML SSO, quotas, billing ([BILLING_PROVIDER])
- Scalabilité horizontale
- Configuration avancée

**Implémentation technique (TypeScript) :**

```typescript
// Flag de configuration
const IS_MULTI_TENANT = process.env.MULTI_TENANT === 'true';

// Middleware automatique
if (IS_MULTI_TENANT) {
  app.use(tenantIsolationMiddleware);
}

// Queries adaptatives
const getENTITIES = IS_MULTI_TENANT
  ? db.entity.findMany({ where: { tenantId: currentTenant } })
  : db.entity.findMany();
```

**Base de données adaptative :**

```sql
-- Schema Community (simple)
CREATE TABLE main_entity (
  id UUID PRIMARY KEY,
  name TEXT NOT NULL,
  ...custom_fields,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Migration vers Enterprise (optionnelle)
ALTER TABLE main_entity ADD COLUMN tenant_id UUID REFERENCES tenants(id);
CREATE INDEX idx_entity_tenant ON main_entity(tenant_id);
```

**Principe :** Le code Community ne doit jamais être alourdi par des vérifications multi-tenant inutiles.

---

## 🎯 CORE FEATURES

### 1. Orchestrateur agents IA multi-tâches

- Support [NUM_AGENTS] agents spécialisés pour [LIST_BUSINESS_TASKS]
- Configuration workflow visuelle (drag-and-drop visual builder avec ReactFlow)
- Exécution parallèle/séquentielle avec DAG (Directed Acyclic Graph)
- Retry/fallback automatique avec exponential backoff
- Preview actions avant exécution (dry-run mode)
- Graph de dépendances agents (DAG visualization)
- Détection cycles automatique
- Optimisation ordre exécution (topological sort)
- Parallélisation automatique tâches indépendantes

**Exemples [LIST_BUSINESS_TASKS] :**
- Triage : fichiers, emails, images, tickets, API custom
- CRM : leads qualification, email sequences, data enrichment
- Analytics : data extraction, report generation, anomaly detection

### 2. Support LLM flexible

- **Local :** Mistral, Llama, Ollama, GPT4All, [CUSTOM_LOCAL_MODELS]
- **API :** OpenAI, Claude (Anthropic), Gemini, [CUSTOM_API_PROVIDERS]
- Interface téléchargement/installation modèles locaux
- Basculement automatique si modèle indisponible
- **Fallback chains :** LLM primaire → secondaire → tertiaire
- Gestion cache et fine-tuning
- **Tracking tokens/coûts API temps réel**
- Quotas configurables par utilisateur/tenant
- Alertes dépassement budget
- Dashboard consommation détaillé
- Prédiction coûts mensuels

### 3. Système de confiance et validation humaine (Human-in-the-loop) 🆕

**Composant CRITIQUE pour la fiabilité :**

```typescript
interface ConfidenceScore {
  score: number; // 0-100
  threshold: number; // Configurable par agent (défaut: [DEFAULT_CONFIDENCE_THRESHOLD])
  factors: {
    llm_confidence: number;
    historical_accuracy: number;
    data_quality: number;
  };
}

interface TaskResult {
  id: string;
  status: 'completed' | 'pending_validation' | 'failed';
  confidence: ConfidenceScore;
  action: AgentAction;
  preview: ActionPreview;
}
```

**Interface validation (style "Tinder Swipe") :**

- Vue "carte par carte" des actions incertaines
- **Swipe Right** = Approuver
- **Swipe Left** = Rejeter
- **Swipe Up** = Voir détails
- **Keyboard shortcuts**
- **Batch validation** (sélection multiple)
- **Apprentissage feedback** (améliore confiance future)

**Queue de validation :**

```typescript
interface ValidationQueue {
  pending: TaskResult[];
  sortBy: 'confidence_asc' | 'date' | 'priority';
  filters: {
    agent_type?: string;
    confidence_range?: [number, number];
    workflow_id?: string;
  };
}
```

**Règles de routing automatique :**

```yaml
validation_rules:
  high_confidence: # ≥ [HIGH_THRESHOLD]
    action: auto_execute
    notify: false
  medium_confidence: # [MED_LOW_THRESHOLD]-[MED_HIGH_THRESHOLD]
    action: auto_execute
    notify: true # Notification post-action
  low_confidence: # < [LOW_THRESHOLD]
    action: queue_for_validation
    notify: true
    priority: high
  critical_actions: # Delete, irreversible...
    action: queue_for_validation
    require_2fa: [REQUIRE_2FA_FOR_CRITICAL] # true/false
```

**Valeurs suggérées :**
- `[DEFAULT_CONFIDENCE_THRESHOLD]` = 80
- `[HIGH_THRESHOLD]` = 90
- `[MED_HIGH_THRESHOLD]` = 89
- `[MED_LOW_THRESHOLD]` = 70
- `[LOW_THRESHOLD]` = 70
- `[REQUIRE_2FA_FOR_CRITICAL]` = false (Community) / true (Enterprise)

### 4. Modules métiers (plugins extensibles)

**[MODULE_1_NAME]** - [MODULE_1_DESCRIPTION]
- Fonctionnalité 1
- Fonctionnalité 2
- Fonctionnalité 3

**[MODULE_2_NAME]** - [MODULE_2_DESCRIPTION]
- Fonctionnalité 1
- Fonctionnalité 2

**[MODULE_3_NAME]** - [MODULE_3_DESCRIPTION]
- Fonctionnalité 1
- Fonctionnalité 2

**Data Analysis** - Extraction et structuration de données non structurées (universel)

**Exemples de remplissage :**
- Triage de fichiers : Renommage IA, classification, déplacement automatique
- Emails : Tri IMAP/Gmail API, priorisation intelligente, extraction données
- Photos : Analyse EXIF, reconnaissance contenu, dédoublonnage

### 5. Connecteurs prêts à l'emploi

- **Stockage** : local, NAS, S3, Google Drive, Dropbox, OneDrive, MinIO, [CUSTOM_STORAGE]
- **Email** : IMAP, POP3, Exchange, Gmail API, Outlook API, [CUSTOM_EMAIL]
- **Messaging** : Slack, Discord, Teams, Telegram, WhatsApp, [CUSTOM_MESSAGING]
- **Bases de données** : PostgreSQL, MySQL, MongoDB, SQLite, Redis, [CUSTOM_DB]
- **Ticketing** : Jira, GitHub Issues, GitLab, Linear, Trello, Asana, [CUSTOM_TICKETING]
- **Cloud** : AWS, Azure, GCP, [CUSTOM_CLOUD]
- **Vision/OCR** : Tesseract, Google Vision, AWS Rekognition, [CUSTOM_VISION]
- **CRM** : Salesforce, HubSpot, Pipedrive, [CUSTOM_CRM]
- **Auth** : OAuth2 (Google, GitHub, Microsoft), SAML SSO (Enterprise), LDAP/Active Directory

---

## 🎨 UI/UX DESIGN

### Design System

**Style visuel :**
- Design [DESIGN_STYLE] moderne (glassmorphic/neumorphic/minimal/autre)
- Thème dark/light avec transition fluide
- Palette couleurs : [COLOR_PALETTE]
- Responsive : desktop/tablet/mobile
- Animations fluides et micro-interactions
- **Accessibility : WCAG 2.1 AA compliant**

**Exemples :**
- `[DESIGN_STYLE]` : glassmorphic | neumorphic | minimal | material
- `[COLOR_PALETTE]` : gradient #143795 → #E4930F | indigo-500 + amber-400 | custom from brand

**Composants UI :**
- Navigation clavier complète (tab order logique)
- Raccourcis clavier configurables
- Support screen readers (ARIA labels complets)
- Contraste couleurs validé (4.5:1 minimum)
- Focus indicators visibles
- Textes alternatifs images
- Skip navigation links
- Taille police ajustable

### Interface utilisateur

**Dashboard central :**
- Métriques temps réel : tâches actives, succès/échec, performance
- Widget "Validation Queue" prominent (badge nombre tâches en attente)
- Graphiques interactifs (Recharts)
- Widgets configurables (drag-and-drop dashboard)
- Alertes et notifications prominentes
- Quick actions : démarrer workflow, voir logs, config

**Validation Interface (Human-in-the-loop) :**

```
┌─────────────────────────────────────────┐
│  Validation Queue (12 pending)          │
│─────────────────────────────────────────│
│  Preview                  │  Content     │
│  [Action Details]         │              │
│                           │  Confidence: │
│  ← Reject    Details ↑    │  65%         │
│                 Approve →  │              │
└─────────────────────────────────────────┘
  Keyboard: ← Reject | → Approve | ↑ Details
```

**Visual Workflow Builder :**
- Drag-and-drop nodes (style n8n/Zapier) avec ReactFlow
- Connexions visuelles entre agents
- Configuration inline par node
- Preview données à chaque étape
- Validation temps réel
- Templates préconfigurés
- Import/export : JSON, YAML

**Configuration agents :**
- Formulaires intuitifs par type agent
- Configuration seuil confiance (slider 0-100)
- Validation inputs temps réel
- Help text contextuel
- Examples/placeholders utiles
- Test connection/credentials

**Logs et monitoring :**
- Live logs avec WebSocket
- Filtres avancés : date, niveau, agent, workflow, confidence
- Recherche full-text
- Export logs : CSV, JSON
- Colorisation syntaxique
- Stack traces cliquables

**Library et Marketplace :**
- Templates workflows préconfigurés
- Workflows communautaires (rating, reviews, trending)
- Installation one-click
- Preview workflow avant install
- Catégories et tags
- Recherche sémantique via pgvector

**Onboarding et aide :**
- Wizard interactif première connexion
- Tutoriels contextuels (tooltips, popovers)
- Aide intégrée recherchable (Algolia DocSearch)
- Vidéos tutoriels embedded
- Chatbot support IA intégré (RAG sur documentation avec pgvector)
- Playground interactif (sandbox test)

### Internationalisation (i18n)

- Support multi-langue complet (fichiers JSON modulaires avec react-i18next)
- Langues initiales : [PRIMARY_LANGUAGE], [SECONDARY_LANGUAGES]
- Interface traduction pour ajout langues
- Détection automatique langue navigateur
- Formats dates/nombres/devises localisés
- RTL support (arabe, hébreu)

**Exemples :**
- `[PRIMARY_LANGUAGE]` : FR | EN | DE | ES
- `[SECONDARY_LANGUAGES]` : EN, DE, ES, IT | FR, ES, PT, ZH

---

## 🔒 SÉCURITÉ

### Authentification & Autorisation

**Multi-utilisateurs (Mode Community simple, Mode Enterprise avancé) :**

- Inscription/connexion : email+password
- OAuth2 providers : [OAUTH_PROVIDERS]
- SAML SSO enterprise (Mode Enterprise uniquement)
- LDAP/Active Directory integration (Mode Enterprise uniquement)
- 2FA optionnel (TOTP avec QR code)
- JWT + refresh tokens
- API keys pour accès programmatique
- Session management sécurisé (httpOnly cookies)

**Exemples [OAUTH_PROVIDERS] :**
- Standard : Google, GitHub, Microsoft
- Spécifique : LinkedIn, Salesforce, Custom

**RBAC (Role-Based Access Control) :**

- **Mode Community :** Rôles simples (Admin, User)
- **Mode Enterprise :** Rôles étendus (Admin, Manager, User, Viewer, [CUSTOM_ROLES])
- Permissions granulaires par ressource
- Permissions par workflow : read/write/execute/delete
- **Audit trail complet** (qui/quand/quoi/comment)

### Protection données

**Chiffrement :**
- **TLS/SSL obligatoire** (transit)
  - Let's Encrypt auto-renew
  - Certificats auto-signés pour déploiement local
- **AES-256** chiffrement au repos (données sensibles : credentials, API keys)
- Chiffrement secrets et credentials
- Gestion secrets : HashiCorp Vault compatible OU simple fichier chiffré pour Community

**Sécurité applicative :**
- Sanitization inputs (anti-XSS, SQL injection)
- Prepared statements ORM (Prisma) avec validation Zod
- Anti-CSRF tokens
- Content Security Policy (CSP)
- Subresource Integrity (SRI)
- **Rate limiting** : connexions et API (Redis sliding window)
- IP whitelisting/blacklisting (optionnel)
- Honeypot anti-bot
- CAPTCHA/v3 optionnel ([CAPTCHA_PROVIDER]) pour self-hosted

**Exemples [CAPTCHA_PROVIDER] :**
- Cloudflare Turnstile (gratuit)
- hCaptcha
- reCAPTCHA v3

### Execution Safety

**Sandbox pour exécution code 🆕 IMPORTANT**

**❌ Docker-in-Docker est trop lourd et instable pour du local**

**Solution privilégiée : WebAssembly (WASM) + Firecracker (microVMs)**

```typescript
interface CodeExecutionSandbox {
  type: 'wasm' | 'firecracker' | 'docker'; // Par ordre de préférence
  
  wasm: { // ✅ Priorité 1
    runtime: 'wasmtime' | 'wasmer';
    memory_limit: [WASM_MEMORY_LIMIT];
    timeout: [WASM_TIMEOUT];
    filesystem: 'readonly' | 'isolated';
  };
  
  firecracker: { // ✅ Pour workloads plus lourds (Linux + KVM only)
    kernel: 'vmlinux';
    memory: [FIRECRACKER_MEMORY];
    vcpus: [FIRECRACKER_VCPUS];
    network: 'none'; // Isolation réseau totale
  };
  
  docker: { // ⚠️ Fallback uniquement
    image: '[PROJECT_NAME_LOWER]-sandbox:alpine';
    network_mode: 'none';
    readonly: true;
    memory: [DOCKER_MEMORY];
    cpus: [DOCKER_CPUS];
  };
}
```

**Valeurs suggérées :**
- `[WASM_MEMORY_LIMIT]` = 128MB
- `[WASM_TIMEOUT]` = 30s
- `[FIRECRACKER_MEMORY]` = 512MB
- `[FIRECRACKER_VCPUS]` = 1
- `[DOCKER_MEMORY]` = 256m
- `[DOCKER_CPUS]` = 0.5

**Stratégie d'isolation :**

1. **Scripts simples (Python, JS) → WASM** (ultra rapide, sécurisé)
2. **Workflows complexes → Firecracker microVM** (isolation kernel) - Linux only
3. **Cas extrêmes → Docker** (dernier recours)

**Auto-détection OS 🔧 CRITIQUE :**

```typescript
function detectOptimalSandbox(): SandboxType {
  const forced = process.env.SANDBOX_TYPE;
  if (forced && forced !== 'auto') return forced;
  
  // Linux + KVM disponible?
  if (process.platform === 'linux' && hasKVM()) return 'firecracker';
  
  // WASM disponible (tous OS)
  if (wasmtimeAvailable()) return 'wasm';
  
  // Fallback Docker
  return 'docker';
}
```

**Validation avant exécution :**

```typescript
interface PreExecutionCheck {
  static_analysis: {
    dangerous_functions: string[]; // exec, eval, rm, etc.
    file_access: string[];
    network_calls: string[];
  };
  risk_score: number; // 0-100
  approval_required: boolean; // Si risk_score > [RISK_THRESHOLD]
}
```

**Valeurs suggérées :**
- `[RISK_THRESHOLD]` = 80

**Human-in-the-loop pour code critique :**
- Scripts générés par LLM → **toujours en quarantaine**
- Preview code avant exécution
- Confidence score < [LOW_THRESHOLD] → validation manuelle obligatoire
- Actions destructrices (delete, rm, drop) → confirmation + 2FA_IF_ENABLED

### Isolation & Contrôle

**Sandbox agents :**
- Conteneurs isolés (optionnels : Firecracker préféré, Linux only)
- Resource limits : CPU, RAM, disk configurables
- Network isolation par défaut (pas d'accès internet)
- Anti-prompt injection : validation LLM inputs avec regex et filtres
- Validation permissions avant exécution
- Timeout configurables par agent (défaut : [AGENT_TIMEOUT] minutes)

**Valeurs suggérées :**
- `[AGENT_TIMEOUT]` = 5

**Résilience :**
- Circuit breaker pattern pour appels externes (ex: API LLM)
- Dead letter queue : tâches échouées (Redis)
- Retry policy avec exponential backoff : [RETRY_SEQUENCE]
- Graceful degradation : mode dégradé si LLM down
- Health checks et liveness probes

**Exemples [RETRY_SEQUENCE] :**
- Standard : 1s, 2s, 4s, 8s, 16s (max)
- Rapide : 0.5s, 1s, 2s, 4s
- Patient : 2s, 5s, 10s, 30s

**Audit et traçabilité :**
- Logs immuables (append-only)
- Audit trail complet : CRUD operations
- Versioning workflows (git-like) avec diffs
- Rollback automatique si erreur détectée
- Checkpoints réguliers (style [CHECKPOINT_PATTERN])

**Exemples [CHECKPOINT_PATTERN] :**
- `AI_CHECKPOINT.json` (style Krigs)
- `.snapshots/`
- `backup/checkpoints/`

### Compliance

**RGPD ready :**
- Anonymisation données personnelles (hashing SHA-256)
- Export données utilisateur (format JSON machine-readable)
- Droit à l'oubli : suppression complète (CASCADE)
- Gestion consentement utilisateur (opt-in cookies, analytics)
- Politique de confidentialité template (Markdown éditable)
- Cookie consent banner (respecte choix utilisateur)

**Audit compliance :**
- Logs conformes [COMPLIANCE_STANDARDS] (format JSON structuré)
- Rapports compliance automatiques (export PDF/CSV)
- Retention policies configurables : [RETENTION_DAYS] jours par défaut

**Exemples :**
- `[COMPLIANCE_STANDARDS]` : SOC2/ISO27001 | HIPAA | PCI-DSS
- `[RETENTION_DAYS]` : 90

---

## ⚙️ ARCHITECTURE TECHNIQUE

### Stack recommandée

**Backend :**
- Runtime : [BACKEND_RUNTIME] (TypeScript strict mode)
- Framework : [BACKEND_FRAMEWORK]
- ORM : [ORM_CHOICE] (type-safety + migrations)
- Validation : Zod (runtime validation + TypeScript inference)
- Queue : BullMQ avec Redis (jobs async + retry)
- WebSocket : Socket.io (temps réel dashboard)
- Auth : JWT (jsonwebtoken) + [PASSWORD_HASH] (hashing passwords)
- Sandbox : Wasmtime (WASM) + Firecracker (microVMs)

**Exemples :**
- `[BACKEND_RUNTIME]` : Node.js 20 LTS | Bun 1.0+ | Deno 2.0+
- `[BACKEND_FRAMEWORK]` : Fastify (performance) | Express.js (simplicité) | Hono (edge-ready)
- `[ORM_CHOICE]` : Prisma | Drizzle | TypeORM
- `[PASSWORD_HASH]` : bcrypt | argon2

**Frontend :**
- Framework : [FRONTEND_FRAMEWORK] avec TypeScript strict
- Build tool : [BUILD_TOOL] (HMR ultra rapide)
- UI Library : [UI_LIBRARY]
- Workflow Editor : ReactFlow (visual graph editor)
- State management : [STATE_MANAGER]
- Forms : React Hook Form + Zod validation
- Charts : Recharts (composable)
- i18n : react-i18next
- HTTP client : TanStack Query (caching + optimistic updates)

**Exemples :**
- `[FRONTEND_FRAMEWORK]` : React 18+ | Vue 3 | Svelte 5 | Solid.js
- `[BUILD_TOOL]` : Vite | Turbopack | esbuild
- `[UI_LIBRARY]` : Radix UI + TailwindCSS + shadcn/ui | Material-UI | Chakra UI
- `[STATE_MANAGER]` : Zustand | Jotai | Redux Toolkit | Pinia (Vue)

**Base de données 🆕 NOUVEAU - Mémoire Vectorielle OBLIGATOIRE pour IA moderne**

```yaml
databases:
  primary:
    type: PostgreSQL 15+
    extensions:
      - pgvector # 🔧 CRITIQUE pour embeddings et recherche sémantique
      - uuid-ossp
      - pg_trgm # Recherche full-text fuzzy
  
  cache:
    type: Redis 7+
    usage:
      - Sessions utilisateur
      - Cache LLM responses (par hash du prompt)
      - Queue jobs (BullMQ)
      - Rate limiting
  
  search: 
    type: pgvector # ✅ intégré dans PostgreSQL
    alternative: [SEARCH_ENGINE] # optionnel pour UI search avancée
```

**Exemples [SEARCH_ENGINE] :**
- MeiliSearch (rapide, facile)
- ElasticSearch (puissant, complexe)
- Typesense (moderne, self-hosted friendly)

**Configuration pgvector 🔧 CRITIQUE :**

```sql
-- Installation extension
CREATE EXTENSION IF NOT EXISTS vector;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- Table pour embeddings (RAG, recherche sémantique)
CREATE TABLE embeddings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  content TEXT NOT NULL,
  embedding vector([EMBEDDING_DIMENSIONS]), -- Dépend du modèle
  provider TEXT NOT NULL, -- 'local' | 'openai' | CUSTOM
  model TEXT NOT NULL, -- Nom du modèle utilisé
  metadata JSONB,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Index HNSW pour recherche rapide (ANN - Approximate Nearest Neighbors)
CREATE INDEX ON embeddings USING hnsw (embedding vector_cosine_ops) WHERE provider = 'local';
CREATE INDEX ON embeddings USING hnsw (embedding vector_cosine_ops) WHERE provider = 'openai';

-- Exemple recherche sémantique
SELECT 
  content,
  1 - (embedding <=> query_embedding) AS similarity
FROM embeddings
WHERE 
  provider = [EMBEDDING_PROVIDER]
  AND 1 - (embedding <=> query_embedding) > [SIMILARITY_THRESHOLD]
ORDER BY embedding <=> query_embedding
LIMIT [SEARCH_LIMIT];
```

**Valeurs suggérées :**
- `[EMBEDDING_DIMENSIONS]` = 384 (all-MiniLM-L6-v2) | 1536 (OpenAI text-embedding-3-small)
- `[EMBEDDING_PROVIDER]` = local | openai
- `[SIMILARITY_THRESHOLD]` = 0.7
- `[SEARCH_LIMIT]` = 10

**⚠️ IMPORTANT : Gestion dimensions variables**

Si vous supportez plusieurs providers avec dimensions différentes :

**Option 1 : Table par dimension**
```sql
CREATE TABLE embeddings_384 (embedding vector(384), ...);
CREATE TABLE embeddings_1536 (embedding vector(1536), ...);
```

**Option 2 : Dimension max + filtrage par provider**
```sql
CREATE TABLE embeddings (
  embedding vector(1536), -- Dimension max
  provider TEXT NOT NULL,
  ...
);
-- Padding/truncation côté application si nécessaire
```

**Embeddings pour RAG et recherche sémantique :**

```typescript
interface EmbeddingService {
  provider: 'local' | 'openai' | [CUSTOM_EMBEDDING];
  
  local: {
    model: [LOCAL_EMBEDDING_MODEL];
    dimensions: [LOCAL_DIMENSIONS];
  };
  
  openai: {
    model: [OPENAI_EMBEDDING_MODEL];
    dimensions: [OPENAI_DIMENSIONS];
  };
}
```

**Exemples :**
- `[LOCAL_EMBEDDING_MODEL]` : all-MiniLM-L6-v2 | all-mpnet-base-v2
- `[LOCAL_DIMENSIONS]` : 384 | 768
- `[OPENAI_EMBEDDING_MODEL]` : text-embedding-3-small | text-embedding-3-large
- `[OPENAI_DIMENSIONS]` : 1536 | 3072

**Cas d'usage pgvector dans [PROJECT_NAME] :**

1. **Recherche sémantique [ENTITIES]** → trouve [ENTITY] pour "[USE_CASE]" (trouve similaires même sans mot-clé exact)
2. **RAG documentation** → Chatbot aide cherche dans docs avec contexte sémantique
3. **Dédoublonnage intelligent** → Détecte items similaires même si noms différents
4. **Classification auto** → Compare nouveaux items → corpus existant
5. **Mémoire long-terme agents** → Agents se souviennent de contexte passé

**Exemples de remplissage :**
- `[ENTITIES]` : workflows | documents | products | users
- `[ENTITY]` : workflow | document | produit
- `[USE_CASE]` : trier mes factures | analyser sentiment | recommandations items

**LLM Integration :**
- Local : [LOCAL_LLM_PROVIDERS]
- API : [API_LLM_PROVIDERS]
- Orchestration : [LLM_ORCHESTRATION] pour RAG + agents

**Exemples :**
- `[LOCAL_LLM_PROVIDERS]` : Ollama API, llama.cpp, GPT4All, LocalAI
- `[API_LLM_PROVIDERS]` : OpenAI SDK, Anthropic SDK, Google Generative AI, Groq
- `[LLM_ORCHESTRATION]` : LangChain | LlamaIndex | Haystack

**DevOps :**
- Container : Docker + Docker Compose
- Orchestration : Kubernetes (optionnel, pour scaling)
- CI/CD : [CI_PLATFORM] (gratuit, intégré)
- Monitoring : Prometheus + Grafana (stack complète)
- Logs : [LOGGING_LIBRARY] (format JSON structuré)
- Tracing : OpenTelemetry (optionnel pour debugging distribué)

**Exemples :**
- `[CI_PLATFORM]` : GitHub Actions | GitLab CI | CircleCI
- `[LOGGING_LIBRARY]` : Pino (Node) | Winston (Node) | Loguru (Python) | slog (Go)

### Architecture système

**Pattern : microservices découplé mais monolithe par défaut pour Community**

**Mode Community : Monolithe modulaire**

```
┌─────────────────────────────────────┐
│  [PROJECT_NAME] App                 │
│  ([BACKEND_RUNTIME] + [FRONTEND])   │
├─────────────────────────────────────┤
│  API Gateway                        │
│  Orchestrator Engine                │
│  Worker Pool                        │
├─────────────────────────────────────┤
│  DB (PG+vector) │ Redis │ Queue     │
└─────────────────────────────────────┘
```

**Mode Enterprise : Microservices (optionnel)**

```
┌────────────────────┐
│  API Gateway       │ ([REVERSE_PROXY])
│  Web UI            │
└────────┬───────────┘
         │
    ┌────┴───────┐
    │            │
┌───▼────┐  ┌───▼────────┐
│Orchestr│  │ Worker     │ (agent execution pool)
│ -ator  │  │ Pool       │
│Service │  └────┬───────┘
└───┬────┘       │
    │            │
┌───▼────────────▼────┐
│ Message Queue       │ ([MESSAGE_QUEUE])
└─────────┬───────────┘
          │
    ┌─────▼─────┐
    │ DB (PG+   │
    │ pgvector) │
    └───────────┘
```

**Exemples :**
- `[REVERSE_PROXY]` : Nginx | Traefik | Caddy
- `[MESSAGE_QUEUE]` : Redis Pub/Sub | RabbitMQ | NATS

**Communication :**
- Event-driven : Redis Pub/Sub pour Community, [MESSAGE_QUEUE] pour Enterprise
- REST API entre services (si microservices)
- WebSocket pour temps réel UI ↔ Backend
- gRPC (optionnel) : services internes haute performance

**Scalabilité :**
- Horizontal scaling ready (stateless services)
- Load balancing : [REVERSE_PROXY]
- Database connection pooling : [DB_POOLER]
- Redis clustering pour cache distribué
- Worker auto-scaling basé sur queue depth

**Exemples [DB_POOLER] :**
- PgBouncer (PostgreSQL)
- Prisma built-in pooling
- pgpool-II

### Performance

**Optimisations backend :**
- Caching stratégique (Redis)
  - Résultats LLM : cache by prompt hash (SHA-256), TTL [LLM_CACHE_TTL]
  - User sessions : TTL selon config
  - Metadata entities : invalidation à la modification
  - Embeddings : cache pour éviter re-calcul
- Connection pooling DB : [DB_POOLER] ou Prisma built-in
- Rate limiting : Redis (sliding window) - [RATE_LIMIT] req/min par IP
- Pagination résultats API : curseur + limit, jamais offset
- Compression responses : gzip/brotli automatique
- CDN pour assets statiques : [CDN_PROVIDER] (gratuit)

**Valeurs suggérées :**
- `[LLM_CACHE_TTL]` = 24h
- `[RATE_LIMIT]` = 100
- `[CDN_PROVIDER]` : Cloudflare | BunnyCDN | jsDelivr

**Optimisations frontend :**
- Code splitting automatique : [BUILD_TOOL] + lazy imports
- Lazy loading routes et composants : React.lazy + Suspense
- Image optimization : WebP auto-conversion, lazy loading
- Service Worker : PWA, cache stratégies
- Debounce/throttle inputs : search, sliders
- Virtual scrolling grandes listes : react-window
- Memoization composants : React.memo, useMemo, useCallback

---

## 🚀 DÉPLOIEMENT

### Docker

**Dockerfile multi-stage optimisé :**

```dockerfile
# Build stage
FROM [BASE_IMAGE] AS builder
WORKDIR /app

# Install dependencies only (cache layer)
COPY package.json .
RUN [PACKAGE_MANAGER] ci --only=production

# Copy source and build
COPY . .
RUN [PACKAGE_MANAGER] run build

# Production stage
FROM [BASE_IMAGE]
WORKDIR /app

# Install pgvector client si besoin
RUN [INSTALL_PG_CLIENT]

# Copy from builder
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules

# Security: run as non-root
RUN addgroup -g 1001 -S [PROJECT_NAME_LOWER] && adduser -S [PROJECT_NAME_LOWER] -u 1001
USER [PROJECT_NAME_LOWER]

EXPOSE [APP_PORT]
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s \
  CMD node healthcheck.js || exit 1

CMD ["node", "dist/index.js"]
```

**Exemples :**
- `[BASE_IMAGE]` : node:20-alpine | bun:1-alpine | deno:alpine
- `[PACKAGE_MANAGER]` : npm | pnpm | yarn | bun
- `[INSTALL_PG_CLIENT]` : apk add --no-cache postgresql-client (Alpine) | apt-get install postgresql-client (Debian)
- `[APP_PORT]` : 3000

**docker-compose.yml complet :**

```yaml
version: '3.8'

services:
  app:
    build: .
    ports:
      - "[APP_PORT]:[APP_PORT]"
    environment:
      - NODE_ENV=production
      - DATABASE_URL=postgresql://[DB_USER]:[DB_PASS]@db:5432/[DB_NAME]
      - REDIS_URL=redis://redis:6379
      - MULTI_TENANT=[MULTI_TENANT_DEFAULT] # false pour Community
    depends_on:
      db:
        condition: service_healthy
      redis:
        condition: service_healthy
    volumes:
      - ./data:/app/data
      - ./uploads:/app/uploads
    restart: unless-stopped
    networks:
      - [PROJECT_NAME_LOWER]-network

  db:
    image: pgvector/pgvector:pg15 # ✅ Image avec pgvector pré-installé
    environment:
      POSTGRES_USER: [DB_USER]
      POSTGRES_PASSWORD: [DB_PASS]
      POSTGRES_DB: [DB_NAME]
    volumes:
      - postgres-data:/var/lib/postgresql/data
      - ./init.sql:/docker-entrypoint-initdb.d/init.sql # Init pgvector
    restart: unless-stopped
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U [DB_USER]"]
      interval: 10s
      timeout: 5s
      retries: 5
    networks:
      - [PROJECT_NAME_LOWER]-network

  redis:
    image: redis:7-alpine
    volumes:
      - redis-data:/data
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 3s
      retries: 5
    networks:
      - [PROJECT_NAME_LOWER]-network

  worker:
    build: .
    command: [PACKAGE_MANAGER] run worker
    environment:
      - NODE_ENV=production
      - DATABASE_URL=postgresql://[DB_USER]:[DB_PASS]@db:5432/[DB_NAME]
      - REDIS_URL=redis://redis:6379
    depends_on:
      - db
      - redis
    volumes:
      - ./data:/app/data
    restart: unless-stopped
    deploy:
      replicas: [WORKER_REPLICAS] # Nombre de workers
    networks:
      - [PROJECT_NAME_LOWER]-network

volumes:
  postgres-data:
  redis-data:

networks:
  [PROJECT_NAME_LOWER]-network:
    driver: bridge
```

**Valeurs suggérées :**
- `[DB_USER]` : Nom projet en lowercase
- `[DB_PASS]` : Généré aléatoirement
- `[DB_NAME]` : Nom projet en lowercase
- `[MULTI_TENANT_DEFAULT]` : false
- `[WORKER_REPLICAS]` : 2

**init.sql pour pgvector :**

```sql
-- Enable pgvector extension
CREATE EXTENSION IF NOT EXISTS vector;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- Create embeddings table
CREATE TABLE IF NOT EXISTS embeddings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  content TEXT NOT NULL,
  embedding vector([EMBEDDING_DIMENSIONS]),
  provider TEXT NOT NULL,
  model TEXT NOT NULL,
  metadata JSONB,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Indexes par provider
CREATE INDEX ON embeddings USING hnsw (embedding vector_cosine_ops) WHERE provider = 'local';
CREATE INDEX ON embeddings USING hnsw (embedding vector_cosine_ops) WHERE provider = 'openai';
```

**Variables environnement documentées (.env.example) :**

```env
# DATABASE
DATABASE_URL=postgresql://[DB_USER]:[DB_PASS]@localhost:5432/[DB_NAME]

# REDIS
REDIS_URL=redis://localhost:6379

# AUTHENTICATION
JWT_SECRET=CHANGE_ME_IN_PRODUCTION_USE_OPENSSL_RAND
JWT_EXPIRES_IN=[JWT_EXPIRY]

# MULTI-TENANT
MULTI_TENANT=[MULTI_TENANT_DEFAULT] # true pour mode Enterprise

# LLM APIs
OPENAI_API_KEY=sk-...
ANTHROPIC_API_KEY=sk-ant-...
OLLAMA_URL=http://localhost:11434 # Pour local LLM
[CUSTOM_LLM_API_KEYS]

# EMAIL (SMTP)
SMTP_HOST=[SMTP_HOST]
SMTP_PORT=[SMTP_PORT]
SMTP_USER=[SMTP_USER]
SMTP_PASS=[SMTP_PASS]

# APP
NODE_ENV=production
PORT=[APP_PORT]
LOG_LEVEL=[LOG_LEVEL] # debug, info, warn, error

# VALIDATION HUMAINE
DEFAULT_CONFIDENCE_THRESHOLD=[DEFAULT_CONFIDENCE_THRESHOLD] # 0-100, actions < seuil → validation queue

# SANDBOX
SANDBOX_TYPE=[SANDBOX_TYPE_DEFAULT] # auto, wasm, firecracker, docker
SANDBOX_MEMORY_LIMIT=[SANDBOX_MEMORY_LIMIT]
SANDBOX_TIMEOUT=[SANDBOX_TIMEOUT]

# EMBEDDINGS
EMBEDDING_PROVIDER=[EMBEDDING_PROVIDER] # local, openai, [CUSTOM]
EMBEDDING_MODEL=[EMBEDDING_MODEL]
EMBEDDING_DIMENSIONS=[EMBEDDING_DIMENSIONS]

[CUSTOM_ENV_SECTION]
[CUSTOM_ENV_VARS]
```

**Valeurs suggérées :**
- `[JWT_EXPIRY]` : 7d
- `[SMTP_HOST]` : smtp.gmail.com
- `[SMTP_PORT]` : 587
- `[LOG_LEVEL]` : info
- `[SANDBOX_TYPE_DEFAULT]` : auto
- `[SANDBOX_MEMORY_LIMIT]` : 512MB
- `[SANDBOX_TIMEOUT]` : 30s

### Umbrel OS

**umbrel-app.yml :**

```yaml
manifestVersion: 1
id: [PROJECT_ID_LOWERCASE]
name: [PROJECT_NAME]
tagline: [TAGLINE_SHORT]
icon: https://raw.githubusercontent.com/[GITHUB_USER]/[REPO]/main/assets/icon.svg
category: [UMBREL_CATEGORY]
version: [VERSION]
port: [APP_PORT]

description:
  - [DESCRIPTION_LONG]
  - |
    Features:
    - [FEATURE_1]
    - [FEATURE_2]
    - [FEATURE_3]
    - [FEATURE_4]
    - Support LLM local et API
    - Interface moderne avec validation humaine (Human-in-the-loop)
    - Recherche sémantique via pgvector
    - Workflows visuels drag-and-drop
    - [NUM_CONNECTORS]+ connecteurs prêts à l'emploi
    - Open source ([LICENSE]) et 100% self-hosted

developer: [DEVELOPER_NAME]
website: https://github.com/[GITHUB_USER]/[REPO]
repo: https://github.com/[GITHUB_USER]/[REPO]
support: https://github.com/[GITHUB_USER]/[REPO]/issues

gallery:
  - https://raw.githubusercontent.com/[GITHUB_USER]/[REPO]/main/assets/screenshot-dashboard.png
  - https://raw.githubusercontent.com/[GITHUB_USER]/[REPO]/main/assets/screenshot-workflow.png
  - https://raw.githubusercontent.com/[GITHUB_USER]/[REPO]/main/assets/screenshot-validation.png

releaseNotes:
  - v[VERSION]:
      - [RELEASE_NOTES]

dependencies: []
path: ""
defaultUsername: ""
defaultPassword: ""
submitter: [SUBMITTER_NAME]
submission: https://github.com/getumbrel/umbrel-apps/pull/XXX
```

**Exemples :**
- `[UMBREL_CATEGORY]` : automation | productivity | ai | development | media
- `[LICENSE]` : MIT | Apache-2.0 | GPL-3.0
- `[NUM_CONNECTORS]` : 30+
- `[VERSION]` : 1.0.0

**docker-compose.yml pour Umbrel :**

```yaml
version: "3.7"

services:
  app:
    image: ghcr.io/[GITHUB_USER]/[PROJECT_ID_LOWERCASE]:latest
    restart: on-failure
    stop_grace_period: 1m
    ports:
      - "${APP_[PROJECT_ID_UPPER]_PORT}:[APP_PORT]"
    volumes:
      - ${APP_DATA_DIR}/data:/app/data
      - ${APP_DATA_DIR}/uploads:/app/uploads
    environment:
      - DATABASE_URL=postgresql://umbrel:umbrel@db:5432/[DB_NAME]
      - REDIS_URL=redis://redis:6379
      - MULTI_TENANT=false
      - DEFAULT_CONFIDENCE_THRESHOLD=[DEFAULT_CONFIDENCE_THRESHOLD]
    networks:
      - [PROJECT_ID_LOWERCASE]

  db:
    image: pgvector/pgvector:pg15
    restart: on-failure
    volumes:
      - ${APP_DATA_DIR}/postgres:/var/lib/postgresql/data
    environment:
      - POSTGRES_USER=umbrel
      - POSTGRES_PASSWORD=umbrel
      - POSTGRES_DB=[DB_NAME]
    networks:
      - [PROJECT_ID_LOWERCASE]

  redis:
    image: redis:7-alpine
    restart: on-failure
    volumes:
      - ${APP_DATA_DIR}/redis:/data
    networks:
      - [PROJECT_ID_LOWERCASE]

networks:
  [PROJECT_ID_LOWERCASE]:
    driver: bridge
```

### Installation native

**Script install Linux (install.sh) :**

```bash
#!/bin/bash
set -e

echo "🚀 Installation [PROJECT_NAME] par [DEVELOPER_NAME]..."

# Couleurs
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Vérifier prérequis
command -v [RUNTIME_COMMAND] >/dev/null 2>&1 || { echo -e "${RED}[RUNTIME_NAME] [MIN_RUNTIME_VERSION]+ requis${NC}"; exit 1; }
command -v docker >/dev/null 2>&1 || { echo -e "${RED}Docker requis${NC}"; exit 1; }
command -v docker-compose >/dev/null 2>&1 || { echo -e "${RED}Docker Compose requis${NC}"; exit 1; }

# Vérifier version [RUNTIME_NAME]
[VERSION_CHECK_COMMAND]
if [ $VERSION_VAR -lt [MIN_VERSION_NUMBER] ]; then
  echo -e "${RED}[RUNTIME_NAME] [MIN_RUNTIME_VERSION]+ requis (version actuelle: $VERSION_VAR)${NC}"
  exit 1
fi

# Cloner repo
echo "📥 Clonage du repository..."
git clone https://github.com/[GITHUB_USER]/[REPO].git
cd [REPO]

# Installation dépendances
echo "📦 Installation des dépendances..."
[PACKAGE_MANAGER] install

# Configuration
echo "⚙️ Configuration..."
cp .env.example .env

# Génération JWT secret
JWT_SECRET=$(openssl rand -hex 32)
sed -i "s/CHANGE_ME_IN_PRODUCTION_USE_OPENSSL_RAND/$JWT_SECRET/" .env

echo -e "${GREEN}Configuration créée dans .env${NC}"
echo -e "${YELLOW}Veuillez éditer .env pour configurer vos API keys LLM${NC}"
read -p "Appuyez sur Entrée pour ouvrir l'éditeur..."
${EDITOR:-nano} .env

# Build
echo "🏗️ Build de l'application..."
[PACKAGE_MANAGER] run build

# Démarrer services
echo "🐳 Démarrage des services Docker..."
docker-compose up -d

# Attendre que les services soient prêts
echo "⏳ Attente du démarrage des services..."
sleep 10

# Healthcheck
if curl -f http://localhost:[APP_PORT]/health >/dev/null 2>&1; then
  echo -e "${GREEN}✅ Installation terminée avec succès!${NC}"
  echo ""
  echo "📱 Accès : http://localhost:[APP_PORT]"
  echo "📚 Documentation : https://github.com/[GITHUB_USER]/[REPO]#readme"
  echo ""
  echo "👨‍💻 Développé par [DEVELOPER_NAME] - [DEVELOPER_TAGLINE]"
else
  echo -e "${RED}❌ Erreur : les services ne répondent pas${NC}"
  echo "Vérifiez les logs : docker-compose logs"
  exit 1
fi
```

**Exemples de remplissage :**
- `[RUNTIME_COMMAND]` : node | bun | deno | python3
- `[RUNTIME_NAME]` : Node.js | Bun | Deno | Python
- `[MIN_RUNTIME_VERSION]` : 20 | 1.0 | 2.0 | 3.11
- `[VERSION_CHECK_COMMAND]` : NODE_VERSION=$(node -v | cut -dv -f2 | cut -d. -f1)
- `[VERSION_VAR]` : $NODE_VERSION
- `[MIN_VERSION_NUMBER]` : 20
- `[DEVELOPER_TAGLINE]` : Make With Passion | Build Amazing Things

**Script install Windows (install.ps1) :**

```powershell
# Installation [PROJECT_NAME] pour Windows
# Développé par [DEVELOPER_NAME] - [DEVELOPER_TAGLINE]

Write-Host "🚀 Installation [PROJECT_NAME]..." -ForegroundColor Green

# Vérifier prérequis
$runtimeVersion = [RUNTIME_CHECK_COMMAND]
if (-not $runtimeVersion) {
    Write-Host "❌ [RUNTIME_NAME] [MIN_RUNTIME_VERSION]+ requis" -ForegroundColor Red
    exit 1
}

$dockerVersion = docker -v
if (-not $dockerVersion) {
    Write-Host "❌ Docker requis" -ForegroundColor Red
    exit 1
}

# Cloner et installer
Write-Host "📥 Clonage du repository..." -ForegroundColor Cyan
git clone https://github.com/[GITHUB_USER]/[REPO].git
cd [REPO]

Write-Host "📦 Installation des dépendances..." -ForegroundColor Cyan
[PACKAGE_MANAGER] install

# Configuration
Write-Host "⚙️ Configuration..." -ForegroundColor Cyan
Copy-Item .env.example .env

# Génération JWT secret
$jwtSecret = -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 32 | ForEach-Object {[char]$_})
(Get-Content .env) -replace 'CHANGE_ME_IN_PRODUCTION_USE_OPENSSL_RAND', $jwtSecret | Set-Content .env

Write-Host "✅ Configuration créée dans .env" -ForegroundColor Green
Write-Host "⚠️ Veuillez éditer .env pour configurer vos API keys LLM" -ForegroundColor Yellow
Read-Host "Appuyez sur Entrée pour ouvrir l'éditeur"
notepad .env

# Build
Write-Host "🏗️ Build de l'application..." -ForegroundColor Cyan
[PACKAGE_MANAGER] run build

# Démarrer services
Write-Host "🐳 Démarrage des services Docker..." -ForegroundColor Cyan
docker-compose up -d

# Attendre services
Write-Host "⏳ Attente du démarrage..." -ForegroundColor Cyan
Start-Sleep -Seconds 10

# Healthcheck
try {
    $response = Invoke-WebRequest -Uri http://localhost:[APP_PORT]/health -UseBasicParsing
    Write-Host "✅ Installation terminée avec succès!" -ForegroundColor Green
    Write-Host ""
    Write-Host "📱 Accès : http://localhost:[APP_PORT]" -ForegroundColor Cyan
    Write-Host "📚 Documentation : https://github.com/[GITHUB_USER]/[REPO]#readme" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "👨‍💻 Développé par [DEVELOPER_NAME] - [DEVELOPER_TAGLINE]" -ForegroundColor Magenta
} catch {
    Write-Host "❌ Erreur : les services ne répondent pas" -ForegroundColor Red
    Write-Host "Vérifiez les logs : docker-compose logs" -ForegroundColor Yellow
    exit 1
}
```

**Exemples [RUNTIME_CHECK_COMMAND] :**
- Node.js : `node -v`
- Bun : `bun -v`
- Python : `python3 --version`

**Service systemd (Linux) :**

```ini
[Unit]
Description=[PROJECT_NAME] Service
After=network.target postgresql.service redis.service

[Service]
Type=simple
User=[PROJECT_NAME_LOWER]
Group=[PROJECT_NAME_LOWER]
WorkingDirectory=/opt/[PROJECT_NAME_LOWER]
ExecStart=[RUNTIME_EXEC_PATH] dist/index.js
Restart=on-failure
RestartSec=10
StandardOutput=journal
StandardError=journal

# Security hardening
NoNewPrivileges=true
PrivateTmp=true
ProtectSystem=strict
ProtectHome=true
ReadWritePaths=/opt/[PROJECT_NAME_LOWER]/data /opt/[PROJECT_NAME_LOWER]/uploads

[Install]
WantedBy=multi-user.target
```

**Exemples [RUNTIME_EXEC_PATH] :**
- `/usr/bin/node`
- `/usr/local/bin/bun`
- `/usr/bin/python3`

---

## 🧪 TESTS & QUALITÉ

### Tests automatisés

**Tests unitaires ([TEST_COVERAGE]% coverage) :**
- Framework : [TEST_FRAMEWORK]
- Tests composants [FRONTEND_FRAMEWORK] : [TEST_LIBRARY]
- Tests fonctions utils
- Tests services (business logic)
- Mocks services externes (LLM, APIs)
- Tests validation Zod schemas

**Exemples :**
- `[TEST_COVERAGE]` : 80%
- `[TEST_FRAMEWORK]` : Vitest (Node) | Jest | Pytest (Python) | Go test
- `[TEST_LIBRARY]` : React Testing Library | Vue Testing Library | Testing Library

**Tests intégration :**
- Tests API endpoints : [INTEGRATION_TEST_TOOL]
- Tests workflows complets (end-to-end logic)
- Tests connecteurs avec services mocks
- Tests queue et workers (BullMQ)
- Tests pgvector : embeddings + recherche

**Exemples [INTEGRATION_TEST_TOOL] :**
- Supertest (Node/Fastify)
- httpx (Python/FastAPI)
- net/http/httptest (Go)

**Tests E2E :**
- Framework : [E2E_FRAMEWORK] (multi-browser, rapide, stable)
- Scénarios utilisateur complets :
  - Création workflow
  - Validation humaine (swipe interface)
  - Exécution workflow
  - Recherche sémantique
- Tests multi-navigateurs : Chromium, Firefox, WebKit
- Tests responsive : mobile/tablet/desktop
- Screenshots automatiques (visual regression)

**Exemples [E2E_FRAMEWORK] :**
- Playwright (recommandé)
- Cypress
- Puppeteer

**Tests visuels :**
- [VISUAL_TEST_TOOL] (gratuit pour open source)
- Détection régressions UI
- Tests thèmes dark/light
- Comparaison pixel-perfect

**Exemples [VISUAL_TEST_TOOL] :**
- Chromatic
- Percy
- BackstopJS

**Tests performance :**
- Load testing : [LOAD_TEST_TOOL] (scriptable, CI-friendly)
- Benchmarks temps réponse (p50, p95, p99)
- Tests scalabilité (montée en charge progressive)
- Tests mémoire (memory leaks detection)

**Exemples [LOAD_TEST_TOOL] :**
- k6
- Artillery
- Locust

### CI/CD Pipeline

**[CI_PLATFORM] workflow (.github/workflows/ci.yml OU .gitlab-ci.yml) :**

```yaml
name: CI/CD [PROJECT_NAME]

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-[RUNTIME]@v4
        with:
          [RUNTIME]-version: [MIN_RUNTIME_VERSION]
          cache: [PACKAGE_MANAGER]
      - run: [PACKAGE_MANAGER] ci
      - run: [PACKAGE_MANAGER] run lint
      - run: [PACKAGE_MANAGER] run format:check

  type-check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-[RUNTIME]@v4
        with:
          [RUNTIME]-version: [MIN_RUNTIME_VERSION]
          cache: [PACKAGE_MANAGER]
      - run: [PACKAGE_MANAGER] ci
      - run: [PACKAGE_MANAGER] run type-check

  test:
    runs-on: ubuntu-latest
    services:
      postgres:
        image: pgvector/pgvector:pg15
        env:
          POSTGRES_USER: test
          POSTGRES_PASSWORD: test
          POSTGRES_DB: [DB_NAME]_test
        ports:
          - 5432:5432
      redis:
        image: redis:7-alpine
        ports:
          - 6379:6379
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-[RUNTIME]@v4
        with:
          [RUNTIME]-version: [MIN_RUNTIME_VERSION]
          cache: [PACKAGE_MANAGER]
      - run: [PACKAGE_MANAGER] ci
      - run: [PACKAGE_MANAGER] run test:unit
        env:
          DATABASE_URL: postgresql://test:test@localhost:5432/[DB_NAME]_test
          REDIS_URL: redis://localhost:6379
      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          files: ./coverage/coverage-final.json

  test-e2e:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-[RUNTIME]@v4
        with:
          [RUNTIME]-version: [MIN_RUNTIME_VERSION]
          cache: [PACKAGE_MANAGER]
      - run: [PACKAGE_MANAGER] ci
      - run: npx playwright install --with-deps
      - run: [PACKAGE_MANAGER] run test:e2e
      - uses: actions/upload-artifact@v3
        if: always()
        with:
          name: playwright-report
          path: playwright-report/

  security:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run Snyk
        uses: snyk/actions/[RUNTIME]@master
        env:
          SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
      - name: OWASP Dependency Check
        uses: dependency-check/Dependency-Check_Action@main
        with:
          project: [PROJECT_NAME]
          path: '.'
          format: 'HTML'

  build:
    needs: [lint, type-check, test, test-e2e, security]
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-[RUNTIME]@v4
        with:
          [RUNTIME]-version: [MIN_RUNTIME_VERSION]
          cache: [PACKAGE_MANAGER]
      - run: [PACKAGE_MANAGER] ci
      - run: [PACKAGE_MANAGER] run build
      - name: Build Docker image
        uses: docker/build-push-action@v5
        with:
          context: .
          push: false
          tags: [PROJECT_NAME_LOWER]:${{ github.sha }}

  deploy:
    if: github.ref == 'refs/heads/main'
    needs: [build]
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Log in to [CONTAINER_REGISTRY]
        uses: docker/login-action@v3
        with:
          registry: [REGISTRY_URL]
          username: ${{ github.actor }}
          password: ${{ secrets.REGISTRY_TOKEN }}
      - name: Build and push Docker image
        uses: docker/build-push-action@v5
        with:
          context: .
          push: true
          tags: |
            [REGISTRY_URL]/[GITHUB_USER]/[PROJECT_NAME_LOWER]:latest
            [REGISTRY_URL]/[GITHUB_USER]/[PROJECT_NAME_LOWER]:${{ github.sha }}
```

**Exemples :**
- `[CONTAINER_REGISTRY]` : GitHub Container Registry | Docker Hub | GitLab Container Registry
- `[REGISTRY_URL]` : ghcr.io | docker.io | registry.gitlab.com
- `[REGISTRY_TOKEN]` : GITHUB_TOKEN | DOCKERHUB_TOKEN | CI_REGISTRY_PASSWORD

### Quality gates

**Linting et formatting :**
- [LINTER] avec config [LANGUAGE] strict
- [FORMATTER] pour formatting : [FORMAT_RULES]
- [GIT_HOOKS] : pre-commit hooks (lint + format + type-check)
- [STAGED_FILES_TOOL] : lint seulement fichiers modifiés

**Exemples :**
- `[LINTER]` : ESLint | Pylint | golangci-lint | Rubocop
- `[FORMATTER]` : Prettier | Black | gofmt | RuboCop
- `[FORMAT_RULES]` : single quotes, 2 spaces, trailing comma | 120 line length, double quotes
- `[GIT_HOOKS]` : Husky (Node) | pre-commit (Python) | lefthook
- `[STAGED_FILES_TOOL]` : lint-staged | pre-commit

**Type checking :**
- TypeScript strict mode : `strict: true`, `noUncheckedIndexedAccess: true`
  OU
- [LANGUAGE_TYPE_SYSTEM] avec validation runtime

**Exemples [LANGUAGE_TYPE_SYSTEM] :**
- Python : mypy + Pydantic
- Go : native type system
- Rust : native type system

**Security scanning :**
- [SECURITY_SCANNER_1] pour vulnérabilités dépendances (gratuit pour open source)
- Dependabot auto-updates ([CI_PLATFORM] natif)
- CodeQL analysis : détection vulnérabilités code
- OWASP Dependency Check : scan licences + CVE

**Exemples [SECURITY_SCANNER_1] :**
- Snyk
- npm audit
- Safety (Python)
- govulncheck (Go)

**Code coverage :**
- Minimum [TEST_COVERAGE]% couverture (branches, functions, lines)
- Coverage report dans PR : [COVERAGE_SERVICE]
- Blocage merge si coverage baisse > [COVERAGE_DROP_THRESHOLD]%

**Exemples :**
- `[COVERAGE_SERVICE]` : Codecov | Coveralls | CodeClimate
- `[COVERAGE_DROP_THRESHOLD]` : 2%

---

## 📊 MONITORING & OBSERVABILITÉ

### Logs structurés

**Configuration logging ([LOGGING_LIBRARY]) :**

```typescript
import [LOGGER] from '[LOGGING_LIBRARY]';

const logger = [LOGGER](/* ... */);

// Exemple log entry
logger.info({
  correlationId: 'abc-123',
  userId: 'user-456',
  [ENTITY_ID]: '[ENTITY]-789',
  confidence: 65,
  action: '[ACTION_NAME]',
}, 'Low confidence action queued for validation');
```

**Exemples de remplissage :**
- `[LOGGER]` : pino | logger
- `[ENTITY_ID]` : workflowId | taskId | documentId
- `[ENTITY]` : workflow | task | document
- `[ACTION_NAME]` : move_file | classify_email | extract_data
- `[SENSITIVE_FIELDS]` : secret, apiKey, token

**Niveaux de log :**
- `fatal` : Erreur critique (crash imminent)
- `error` : Erreur nécessitant attention
- `warn` : Avertissement (dégradation possible)
- `info` : Événements normaux importants
- `debug` : Informations détaillées pour debugging
- `trace` : Niveau ultra-verbeux (développement uniquement)

**Rotation automatique :**
- Taille max : [LOG_MAX_SIZE] par fichier
- Retention : [LOG_RETENTION_DAYS] jours
- Compression gzip après rotation

**Valeurs suggérées :**
- `[LOG_MAX_SIZE]` : 100MB
- `[LOG_RETENTION_DAYS]` : 30

### Métriques Prometheus

**Endpoints metrics :**

```typescript
import promClient from 'prom-client';

// Métriques custom
const [ENTITY]Executions = new promClient.Counter({
  name: '[PROJECT_NAME_LOWER]_[ENTITY]_executions_total',
  help: 'Total [ENTITY] executions',
  labelNames: ['status', '[ENTITY_ID]'],
});

const validationQueueDepth = new promClient.Gauge({
  name: '[PROJECT_NAME_LOWER]_validation_queue_depth',
  help: 'Number of tasks pending human validation',
});

const confidenceScores = new promClient.Histogram({
  name: '[PROJECT_NAME_LOWER]_confidence_scores',
  help: 'Distribution of confidence scores',
  buckets: [0.5, 0.6, 0.7, 0.8, 0.9, 1.0],
});

const llmLatency = new promClient.Histogram({
  name: '[PROJECT_NAME_LOWER]_llm_latency_seconds',
  help: 'LLM API latency',
  labelNames: ['provider', 'model'],
  buckets: [0.1, 0.5, 1, 2, 5, 10],
});

// Métriques custom spécifiques
[CUSTOM_METRICS]
```

**Dashboard Grafana (template JSON fourni) :**
- Panel système : CPU, RAM, Disk I/O
- Panel application : [ENTITY]s actifs, taux succès, latence
- Panel validation : Queue depth, taux approbation, temps validation
- Panel LLM : Tokens consommés, coûts, latence par provider
- Panel erreurs : Taux erreurs, top errors, stack traces
- [CUSTOM_PANELS]

### Alerting

**Règles Prometheus (prometheus.rules.yml) :**

```yaml
groups:
  - name: [PROJECT_NAME_LOWER]_alerts
    interval: 30s
    rules:
      - alert: HighErrorRate
        expr: |
          rate([PROJECT_NAME_LOWER]_[ENTITY]_executions_total{status="failed"}[5m])
          > [ERROR_RATE_THRESHOLD]
        for: 5m
        labels:
          severity: warning
        annotations:
          summary: "Taux d'erreur élevé"
          description: "Plus de [ERROR_RATE_THRESHOLD_PERCENT]% des [ENTITY]s échouent"

      - alert: ValidationQueueTooLarge
        expr: |
          [PROJECT_NAME_LOWER]_validation_queue_depth > [QUEUE_THRESHOLD]
        for: 10m
        labels:
          severity: info
        annotations:
          summary: "Queue de validation importante"
          description: "{{ $value }} tâches en attente de validation"

      - alert: HighLLMLatency
        expr: |
          histogram_quantile(0.95,
            rate([PROJECT_NAME_LOWER]_llm_latency_seconds_bucket[5m])
          ) > [LLM_LATENCY_THRESHOLD]
        for: 5m
        labels:
          severity: warning
        annotations:
          summary: "Latence LLM élevée"
          description: "P95 latency = {{ $value }}s"

[CUSTOM_ALERT_RULES]
```

**Valeurs suggérées :**
- `[ERROR_RATE_THRESHOLD]` : 0.05 (5%)
- `[ERROR_RATE_THRESHOLD_PERCENT]` : 5%
- `[QUEUE_THRESHOLD]` : 100
- `[LLM_LATENCY_THRESHOLD]` : 5

**Canaux notification :**
- Email (SMTP)
- Slack (webhook)
- Discord (webhook)
- Telegram (bot)
- Webhook custom (JSON payload)
- [CUSTOM_NOTIFICATION_CHANNELS]

---

## 🔌 EXTENSIBILITÉ

### Plugin system

**Architecture plugins :**

```typescript
interface [PROJECT_NAME]Plugin {
  id: string;
  name: string;
  version: string;
  description: string;
  author: string;
  
  // Lifecycle hooks
  onInstall?: () => Promise<void>;
  onUninstall?: () => Promise<void>;
  onEnable?: () => Promise<void>;
  onDisable?: () => Promise<void>;
  
  // Agent factory
  createAgent?: (config: AgentConfig) => Agent;
  
  // UI components ([FRONTEND_FRAMEWORK])
  configUI?: React.ComponentType<ConfigUIProps>;
  dashboardWidget?: React.ComponentType<WidgetProps>;
  
  // API routes ([BACKEND_FRAMEWORK])
  registerRoutes?: (server: [SERVER_INSTANCE]) => void;
  
  // Dependencies
  dependencies?: string[]; // Autres plugins requis
  min[PROJECT_NAME]Version?: string; // Version minimale
}

// Exemple plugin simple
export const [EXAMPLE_PLUGIN_ID]Plugin: [PROJECT_NAME]Plugin = {
  id: '[EXAMPLE_PLUGIN_ID]',
  name: '[EXAMPLE_PLUGIN_NAME]',
  version: '1.0.0',
  description: '[EXAMPLE_PLUGIN_DESCRIPTION]',
  author: '[PLUGIN_AUTHOR]',
  
  createAgent: (config) => new [EXAMPLE_AGENT](/* ... */),
  
  configUI: ({ value, onChange }) => (
    <div>
      <label>[CONFIG_LABEL]</label>
      <input
        type="[INPUT_TYPE]"
        min={[INPUT_MIN]}
        max={[INPUT_MAX]}
        value={value.[CONFIG_KEY]}
        onChange={(e) => onChange({ ...value, [CONFIG_KEY]: e.target.value })}
      />
    </div>
  ),
};
```

**Exemples de remplissage :**
- `[SERVER_INSTANCE]` : FastifyInstance | Express | HonoApp
- `[EXAMPLE_PLUGIN_ID]` : email-spam-filter | data-extractor | sentiment-analyzer
- `[EXAMPLE_PLUGIN_NAME]` : Email Spam Filter | Data Extractor | Sentiment Analyzer
- `[EXAMPLE_PLUGIN_DESCRIPTION]` : Filter spam emails using ML | Extract structured data | Analyze sentiment
- `[PLUGIN_AUTHOR]` : Nom développeur
- `[EXAMPLE_AGENT]` : SpamFilterAgent | DataExtractorAgent
- `[CONFIG_LABEL]` : Spam Threshold | Extraction Mode | Confidence Level
- `[INPUT_TYPE]` : range | text | select
- `[INPUT_MIN]` : 0
- `[INPUT_MAX]` : 100
- `[CONFIG_KEY]` : threshold | mode | confidence

**Plugin management API :**

```typescript
// Installation plugin
POST /api/v1/plugins/install
Body: { url: [PLUGIN_REPO_URL] }

// Liste plugins
GET /api/v1/plugins

// Enable/disable
POST /api/v1/plugins/:id/enable
POST /api/v1/plugins/:id/disable

// Configuration
PATCH /api/v1/plugins/:id/config
Body: [CONFIG_PARAMS]
```

### Webhooks

**Configuration webhook :**

```typescript
interface WebhookConfig {
  id: string;
  url: string;
  events: WebhookEvent[];
  secret: string; // Pour signature HMAC
  headers?: Record<string, string>;
  retry_policy: {
    max_retries: number;
    backoff: 'linear' | 'exponential';
    initial_delay: number;
  };
  filters?: {
    [ENTITY_ID]s?: string[];
    min_confidence?: number;
    [CUSTOM_FILTERS]?: any;
  };
}

type WebhookEvent =
  | '[ENTITY].started'
  | '[ENTITY].completed'
  | '[ENTITY].failed'
  | 'task.validation_required'
  | 'task.validated'
  | 'agent.error'
  | 'quota.exceeded'
  | [CUSTOM_WEBHOOK_EVENTS];
```

**Payload webhook :**

```json
{
  "id": "evt_abc123",
  "event": "task.validation_required",
  "timestamp": "2025-11-23T16:00:00Z",
  "data": {
    "taskId": "task-789",
    "[ENTITY_ID]": "[ENTITY]-456",
    "confidence": 65,
    "action": {
      "type": "[ACTION_TYPE]",
      "[ACTION_FIELD_1]": "[VALUE_1]",
      "[ACTION_FIELD_2]": "[VALUE_2]"
    },
    "preview": {
      "[PREVIEW_FIELD]": "[PREVIEW_VALUE]"
    },
    "estimated_duration": "1s"
  },
  "signature": "sha256:abc..." // HMAC-SHA256
}
```

### API publique

**REST API v1 (OpenAPI 3.0) :**

```yaml
openapi: 3.0.0
info:
  title: [PROJECT_NAME] API
  version: 1.0.0
  description: API pour [API_DESCRIPTION]

paths:
  /[MAIN_ENTITY_PLURAL]:
    get:
      summary: Liste [ENTITIES]
      parameters:
        - name: limit
          in: query
          schema:
            type: integer
            default: 20
        - name: cursor
          in: query
          schema:
            type: string
        [CUSTOM_QUERY_PARAMS]
      responses:
        200:
          content:
            application/json:
              schema:
                type: object
                properties:
                  data:
                    type: array
                    items:
                      $ref: '#/components/schemas/[MAIN_ENTITY]'
                  pagination:
                    $ref: '#/components/schemas/Pagination'
    
    post:
      summary: Créer [ENTITY]
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/Create[MAIN_ENTITY]Input'
      responses:
        201:
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/[MAIN_ENTITY]'
  
  /[MAIN_ENTITY_PLURAL]/{id}/[ACTION]:
    post:
      summary: [ACTION_DESCRIPTION]
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: string
      requestBody:
        content:
          application/json:
            schema:
              type: object
              properties:
                input:
                  type: object
                [ACTION_OPTIONS]:
                  type: [OPTION_TYPE]
                  default: [OPTION_DEFAULT]
      responses:
        202:
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Task'
  
  /validation-queue:
    get:
      summary: Liste tâches en attente de validation
      responses:
        200:
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/ValidationTask'
  
  /validation-queue/{taskId}/approve:
    post:
      summary: Approuver tâche
      responses:
        200:
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Task'
  
  [CUSTOM_API_ENDPOINTS]

components:
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer
      bearerFormat: JWT
    apiKey:
      type: apiKey
      in: header
      name: X-API-Key

security:
  - bearerAuth: []
  - apiKey: []
```

**Exemples de remplissage :**
- `[MAIN_ENTITY]` : Workflow | Document | Project | Task
- `[MAIN_ENTITY_PLURAL]` : workflows | documents | projects | tasks
- `[ENTITY]/[ENTITIES]` : workflow/workflows | document/documents
- `[ACTION]` : execute | analyze | process | export
- `[ACTION_DESCRIPTION]` : Exécuter workflow | Analyser document
- `[ACTION_OPTIONS]` : dryRun | detailed | async
- `[OPTION_TYPE]` : boolean | string | number
- `[OPTION_DEFAULT]` : false | "standard" | 0

---

## 📚 DOCUMENTATION

### Documents à générer (42 livrables minimum)

**Documents (21) :**

1. **README.md** - Introduction, installation rapide, features
2. **ARCHITECTURE.md** - Diagrammes C4, stack, décisions techniques (ADR)
3. **API.md** - Documentation REST [GRAPHQL_IF_USED] + WebSocket
4. **SECURITY.md** - Threat model, best practices, audit
5. **TESTING.md** - Stratégie tests, coverage, CI/CD
6. **MONITORING.md** - Logs, métriques, alerting, dashboards
7. **BACKUP.md** - Stratégie backup/restore, RTO/RPO
8. **PLUGINS.md** - Guide développement plugins
9. **DEPLOYMENT.md** - Docker, Umbrel, Kubernetes, native, [CUSTOM_PLATFORMS]
10. **DEVELOPMENT.md** - Setup dev, contribution, coding standards
11. **USER_GUIDE.md** - Guide utilisateur complet ([PRIMARY_LANGUAGE] prioritaire)
12. **VALIDATION_GUIDE.md** - Guide système validation humaine (HITL)
13. **PGVECTOR_GUIDE.md** - Utilisation embeddings et recherche sémantique
14. **SANDBOX_GUIDE.md** - WASM/Firecracker limitations OS
15. **[CUSTOM_GUIDE_1].md** - [DESCRIPTION]
16. **[CUSTOM_GUIDE_2].md** - [DESCRIPTION]
17. **CHANGELOG.md** - Historique versions (Keep a Changelog format)
18. **CONTRIBUTING.md** - Guide contribution open source
19. **CODE_OF_CONDUCT.md** - Code de conduite (Contributor Covenant)
20. **ROADMAP.md** - Feuille de route 6-12 mois
21. **LICENSE** - [LICENSE] License

**Code (21) :**

22. Structure dossiers complète : [RECOMMENDED_FOLDER_STRUCTURE]
23. Backend boilerplate : [BACKEND_FRAMEWORK] + [ORM_CHOICE] + Zod
24. Frontend boilerplate : [FRONTEND_FRAMEWORK] + TypeScript + [BUILD_TOOL]
25. Schéma [ORM_CHOICE] avec pgvector extension
26. [NUM_AGENTS] agents exemples : [LIST_AGENT_EXAMPLES]
27. [NUM_CONNECTORS] connecteurs : [LIST_CONNECTOR_EXAMPLES]
28. Plugin system complet
29. Validation queue (backend + frontend)
30. Confidence scoring system
31. Sandbox implementation (WASM/Firecracker/Docker fallback)
32. Tests : unit, integration, E2E avec [E2E_FRAMEWORK]
33. [CUSTOM_CODE_COMPONENTS]

**Valeurs suggérées :**
- `[NUM_AGENTS]` : 5
- `[NUM_CONNECTORS]` : 10+
- `[LIST_AGENT_EXAMPLES]` : files, emails, images, API, data
- `[LIST_CONNECTOR_EXAMPLES]` : local FS, IMAP, Drive, PostgreSQL, OpenAI, webhook, RSS, OCR, S3, Slack

### Exemples de code inline

**Documentation [DOC_STANDARD] ([DOC_COMMENT_STYLE] exhaustif) :**

```typescript
/**
 * Execute a [ENTITY] with confidence-based routing.
 * 
 * Tasks with confidence below threshold are queued for human validation.
 * 
 * @param [ENTITY_ID] - Unique [ENTITY] identifier ([ID_FORMAT])
 * @param input - Input data for [ENTITY] execution
 * @param options - Execution options
 * @param options.dryRun - Simulate execution without side effects (default: false)
 * @param options.confidenceThreshold - Override default confidence threshold (0-100)
 * @returns Promise resolving to task execution result
 * @throws {[ENTITY]NotFoundError} If [ENTITY] doesn't exist
 * @throws {QuotaExceededError} If user quota exceeded
 * @throws {ValidationError} If input doesn't match [ENTITY] schema
 * 
 * @example
 * // Execute with default settings
 * const result = await execute[ENTITY]([INPUT_EXAMPLE]);
 * if (result.status === 'pending_validation') {
 *   console.log('Low confidence, requires human validation');
 *   console.log('Confidence:', result.confidence.score);
 * }
 * 
 * @example
 * // Dry-run mode
 * const preview = await execute[ENTITY]([INPUT_EXAMPLE]);
 * console.log('Preview:', preview);
 * 
 * @see {@link [DOCUMENTATION_URL]}
 */
async function execute[ENTITY](/* ... */): Promise<TaskResult> {
  // Implementation
}
```

**Exemples :**
- `[DOC_STANDARD]` : TSDoc | JSDoc | Docstring | GoDoc
- `[DOC_COMMENT_STYLE]` : 
- `[ENTITY]` : Workflow | Task | Document
- `[ID_FORMAT]` : UUID format | nanoid | ULID
- `[INPUT_EXAMPLE]` : { file: 'path/to/file.pdf' } | { text: 'Hello world' } | { data: ... }

---

## 🎯 LIVRABLES ATTENDUS - STRATÉGIE D'EXÉCUTION PAR PHASES

**⚠️ NE PAS TOUT GÉNÉRER D'UN COUP** (context window limit)

### Phase 1 : Initialisation (générer en premier)

Commence par générer :

1. Structure projet complète (dossiers + fichiers + config)
2. docker-compose.yml avec pgvector
3. Schéma [ORM_CHOICE] avec extension vector
4. README.md complet avec badges
5. .env.example documenté
6. package.json avec scripts

**Puis ATTENDS mon "Go" pour la suite.**

### Phase 2 : Backend Core

1. Configuration serveur [BACKEND_FRAMEWORK]
2. Setup base de données [ORM_CHOICE] + pgvector
3. Système authentification (JWT + RBAC)
4. Worker queue (BullMQ + Redis)
5. API routes principales
6. Tests unitaires backend

### Phase 3 : Frontend Core

1. Setup [FRONTEND_FRAMEWORK] + [BUILD_TOOL]
2. Design system et composants
3. Dashboard principal
4. Workflow editor (ReactFlow)
5. Validation queue UI (swipe interface)
6. Tests E2E [E2E_FRAMEWORK]

### Phase 4 : Moteur IA + Agents

1. Classe Agent de base
2. Intégration LLM (local + API)
3. Système mémoire vectorielle (pgvector + embeddings)
4. Confidence scoring
5. [NUM_AGENTS] agents implémentés
6. Sandbox (WASM/Firecracker/Docker)

### Phase 5 : Connecteurs + Polish

1. [NUM_CONNECTORS] connecteurs implémentés
2. Plugin system complet
3. Webhooks
4. Monitoring (Prometheus + Grafana)
5. Scripts backup/restore
6. Documentation complète
7. CI/CD pipeline [CI_PLATFORM]

---

## ✅ CHECKLIST DE REMPLISSAGE (Avant de lancer)

### Identité Projet

- [ ] `[PROJECT_NAME]` - Nom du projet (ex: Klaro, DataFlow, SmartSort)
- [ ] `[PROJECT_ID_LOWERCASE]` - ID lowercase (ex: klaro, dataflow)
- [ ] `[PROJECT_ID_UPPER]` - ID uppercase (ex: KLARO, DATAFLOW)
- [ ] `[DESCRIPTION_TYPE]` - Type (ex: all-in-one, plateforme, système)
- [ ] `[DOMAIN_DESCRIPTION]` - Domaine métier (ex: triage intelligent, CRM IA, analytics)
- [ ] `[TAGLINE_SHORT]` - Tagline court (ex: AI-powered intelligent sorting)
- [ ] `[DESCRIPTION_LONG]` - Description longue (2-3 lignes)

### Développeur

- [ ] `[DEVELOPER_NAME]` - Nom développeur
- [ ] `[DEVELOPER_TAGLINE]` - Tagline (ex: Make With Passion)
- [ ] `[GITHUB_USER]` - Username GitHub
- [ ] `[REPO]` - Nom repo

### Stack Technique

- [ ] `[BACKEND_RUNTIME]` - Runtime backend (ex: Node.js 20)
- [ ] `[BACKEND_FRAMEWORK]` - Framework backend (ex: Fastify)
- [ ] `[FRONTEND_FRAMEWORK]` - Framework frontend (ex: React 18+)
- [ ] `[ORM_CHOICE]` - ORM (ex: Prisma)
- [ ] `[BUILD_TOOL]` - Build tool (ex: Vite)
- [ ] `[PACKAGE_MANAGER]` - Package manager (ex: npm, pnpm)

### Fonctionnel

- [ ] `[LIST_BUSINESS_TASKS]` - Tâches métiers (ex: files, emails, photos)
- [ ] `[MODULE_1_NAME]`, `[MODULE_2_NAME]`, etc. - Modules métiers
- [ ] `[DEFAULT_CONFIDENCE_THRESHOLD]` - Seuil confiance (ex: 80)
- [ ] `[PRIMARY_LANGUAGE]` - Langue principale (ex: FR, EN)

### Configuration Projet

- [ ] `[MIN_RAM]` - RAM minimale (ex: 2GB)
- [ ] `[MIN_DISK]` - Disk minimal (ex: 10GB)
- [ ] `[APP_PORT]` - Port app (ex: 3000)
- [ ] `[VERSION]` - Version initiale (ex: 1.0.0)
- [ ] `[LICENSE]` - Licence (ex: MIT, Apache-2.0)

### Custom Sections (optionnel)

- [ ] `[CUSTOM_ENV_SECTION]` - Sections env custom
- [ ] `[CUSTOM_METRICS]` - Métriques Prometheus custom
- [ ] `[CUSTOM_API_ENDPOINTS]` - Endpoints API custom
- [ ] Tous les autres `[CUSTOM_...]`

**Une fois TOUT rempli → Lance Claude Code avec Phase 1 !**

---

## 🔧 CONTRAINTES & PRINCIPES

### Philosophie [DEVELOPER_NAME]

**🛠️ Développé par [DEVELOPER_NAME] – [DEVELOPER_SIGNATURE]**

**Licence :** [LICENSE] | **MAJ :** 2025-11-10 | **Intégration :** LLM local – Kiro + Claude Code

**🎯 Mission :** Respecter les règles d'un codebase, apprendre des docs & inputs validés, développer & finaliser avec 0% d'erreur, s'adapter à tout projet/langage.

**🧠 Règles :**
- **Zéro hallucination** : sources fiables uniquement
- **Pas de suppression code** sans validation
- **Changements documentés** & rollbackable
- Tout **auditable, restaurable, versionné**
- Code **production-ready** : 0 TODOs/placeholders
- Licence [LICENSE] avec attribution claire

**🔒 Sécurité :**
- Isolation via [CHECKPOINT_PATTERN]
- Auto-save/restore
- Anti-drift code/docs
- Tests visuels auto
- Validation bloquant changements non autorisés

**🔁 Apprentissage :**
- Feedback "Faux" = rollback
- Feedback "Parfait" = documenter & archiver
- Boucle jusqu'à succès

**📌 Objectif :** Développement autonome, fiable, traçable & réversible.

**Exemples :**
- `[DEVELOPER_SIGNATURE]` : Make With Passion | Build Amazing Things | Code with Purpose
- `[CHECKPOINT_PATTERN]` : AI_CHECKPOINT.json | .snapshots/ | checkpoints/

### Standards techniques

- [LANGUAGE] strict mode (100% typed)
- Tests coverage : [TEST_COVERAGE]%
- Documentation inline exhaustive
- Sécurité by design
- Performance optimisée
- Accessibilité WCAG 2.1 AA
- i18n complet ([PRIMARY_LANGUAGE] prioritaire)
- Responsive mobile-first
- SEO-friendly [SEO_IF_PUBLIC]
- Open source friendly : [LICENSE]

---

**Ce Master Template couvre maintenant 100% des besoins avec les éléments critiques :**

✅ Architecture Single/Multi-tenant claire et adaptable
✅ pgvector obligatoire pour recherche sémantique et RAG
✅ Human-in-the-loop avec interface validation style "Tinder"
✅ Sandbox sécurisé (WASM/Firecracker prioritaires, auto-détection OS)
✅ Confidence scoring pour routing automatique
✅ Stratégie d'exécution par phases (évite context window limit)
✅ Tests complets (unit, integration, E2E, visual, load)
✅ Monitoring production-grade (Prometheus + Grafana)
✅ Backup/Recovery + RTO/RPO documentés
✅ CI/CD pipeline complet avec security scanning
✅ API REST complète (OpenAPI spec)
✅ Plugin system extensible
✅ Documentation exhaustive (42 livrables)
✅ Placeholders pour TOUTE customisation

**[PROJECT_NAME] est maintenant architecturalement indestructible et prêt pour génération !**

---

**Signature :**

🛠️ **Développé par [DEVELOPER_NAME] – [DEVELOPER_TAGLINE]**