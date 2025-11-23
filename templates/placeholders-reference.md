# 📋 Placeholders Reference

> Complete list of all customizable placeholders in the Master Template

This document lists all 150+ placeholders available in the `master-template.md` with:
- Description
- Example values
- Default recommendations
- Whether required or optional

---

## 📖 Table of Contents

- [Project Identity](#project-identity)
- [Developer Information](#developer-information)
- [Technical Stack](#technical-stack)
- [Functional Configuration](#functional-configuration)
- [UI/UX Design](#uiux-design)
- [Security & Compliance](#security--compliance)
- [Database & LLM](#database--llm)
- [Deployment](#deployment)
- [Testing & Quality](#testing--quality)
- [Monitoring](#monitoring)
- [Extensibility](#extensibility)
- [Custom Sections](#custom-sections)

---

## Project Identity

### Core Identity

| Placeholder | Description | Example Values | Required |
|------------|-------------|----------------|----------|
| `[PROJECT_NAME]` | Full project name (Title Case) | Klaro, DataFlow, SmartCRM | ✅ |
| `[PROJECT_ID_LOWERCASE]` | Lowercase identifier | klaro, dataflow, smartcrm | ✅ |
| `[PROJECT_ID_UPPER]` | Uppercase identifier | KLARO, DATAFLOW, SMARTCRM | ✅ |
| `[PROJECT_NAME_LOWER]` | Lowercase name for paths | klaro, dataflow, smartcrm | ✅ |
| `[DESCRIPTION_TYPE]` | Type of solution | all-in-one, plateforme, système | ✅ |
| `[DOMAIN_DESCRIPTION]` | Domain/business area | triage intelligent, CRM IA, analytics | ✅ |
| `[TAGLINE_SHORT]` | Short tagline (max 60 chars) | AI-powered intelligent sorting | ✅ |
| `[DESCRIPTION_LONG]` | Detailed description (2-3 lines) | Multi-line project description | ✅ |

### Configuration

| Placeholder | Description | Example Values | Default | Required |
|------------|-------------|----------------|---------|----------|
| `[MIN_RAM]` | Minimum RAM requirement | 2GB, 4GB, 8GB | 2GB | ✅ |
| `[MIN_DISK]` | Minimum disk space | 10GB, 20GB, 50GB | 10GB | ✅ |
| `[APP_PORT]` | Application port | 3000, 8080, 4000 | 3000 | ✅ |
| `[VERSION]` | Initial version | 1.0.0, 0.1.0 | 1.0.0 | ✅ |
| `[LICENSE]` | Open source license | MIT, Apache-2.0, GPL-3.0 | MIT | ✅ |

---

## Developer Information

| Placeholder | Description | Example Values | Required |
|------------|-------------|----------------|----------|
| `[DEVELOPER_NAME]` | Developer full name | Julien Gelée (Krigs) | ✅ |
| `[DEVELOPER_TAGLINE]` | Developer motto | Make With Passion, Build Amazing Things | ✅ |
| `[GITHUB_USER]` | GitHub username | Krigsexe, yourusername | ✅ |
| `[REPO]` | Repository name | Data-Architect-Template | ✅ |
| `[DEVELOPER_SIGNATURE]` | Signature line | Make With Passion. Powered by Discipline. | ⚪ |

---

## Technical Stack

### Backend

| Placeholder | Description | Example Values | Default | Required |
|------------|-------------|----------------|---------|----------|
| `[BACKEND_RUNTIME]` | Backend runtime | Node.js 20 LTS, Bun 1.0+, Deno 2.0+ | Node.js 20 LTS | ✅ |
| `[BACKEND_FRAMEWORK]` | Backend framework | Fastify, Express.js, Hono | Fastify | ✅ |
| `[ORM_CHOICE]` | ORM/database library | Prisma, Drizzle, TypeORM | Prisma | ✅ |
| `[PASSWORD_HASH]` | Password hashing algorithm | bcrypt, argon2 | bcrypt | ✅ |
| `[PACKAGE_MANAGER]` | Package manager | npm, pnpm, yarn, bun | npm | ✅ |
| `[RUNTIME_COMMAND]` | Runtime CLI command | node, bun, deno, python3 | node | ✅ |
| `[RUNTIME_NAME]` | Runtime display name | Node.js, Bun, Deno, Python | Node.js | ✅ |
| `[MIN_RUNTIME_VERSION]` | Minimum runtime version | 20, 1.0, 2.0, 3.11 | 20 | ✅ |

### Frontend

| Placeholder | Description | Example Values | Default | Required |
|------------|-------------|----------------|---------|----------|
| `[FRONTEND_FRAMEWORK]` | Frontend framework | React 18+, Vue 3, Svelte 5, Solid.js | React 18+ | ✅ |
| `[BUILD_TOOL]` | Build tool | Vite, Turbopack, esbuild | Vite | ✅ |
| `[UI_LIBRARY]` | UI component library | Radix UI + TailwindCSS, Material-UI | Radix UI + TailwindCSS | ✅ |
| `[STATE_MANAGER]` | State management | Zustand, Jotai, Redux Toolkit, Pinia | Zustand | ✅ |

### Database & Search

| Placeholder | Description | Example Values | Default | Required |
|------------|-------------|----------------|---------|----------|
| `[DB_USER]` | Database username | postgres, project_name | postgres | ✅ |
| `[DB_PASS]` | Database password | randomly_generated | - | ✅ |
| `[DB_NAME]` | Database name | project_name_db | - | ✅ |
| `[DB_POOLER]` | Connection pooler | PgBouncer, Prisma built-in, pgpool-II | Prisma built-in | ⚪ |
| `[SEARCH_ENGINE]` | Search engine (optional) | MeiliSearch, ElasticSearch, Typesense | - | ⚪ |

---

## Functional Configuration

### Business Logic

| Placeholder | Description | Example Values | Required |
|------------|-------------|----------------|----------|
| `[NUM_AGENTS]` | Number of AI agents | 3, 5, 10 | ✅ |
| `[NUM_CONNECTORS]` | Number of connectors | 10+, 30+, 50+ | ✅ |
| `[LIST_BUSINESS_TASKS]` | List of business tasks | files, emails, photos, tickets | ✅ |
| `[LIST_AGENT_EXAMPLES]` | Agent examples | files, emails, images, API, data | ✅ |
| `[LIST_CONNECTOR_EXAMPLES]` | Connector examples | IMAP, Drive, S3, PostgreSQL | ✅ |

### Modules

| Placeholder | Description | Example Values | Required |
|------------|-------------|----------------|----------|
| `[MODULE_1_NAME]` | First module name | File Triage, Email Manager | ✅ |
| `[MODULE_1_DESCRIPTION]` | First module description | AI renaming, classification... | ✅ |
| `[MODULE_2_NAME]` | Second module name | Data Analysis | ⚪ |
| `[MODULE_2_DESCRIPTION]` | Second module description | Extract structured data | ⚪ |
| `[MODULE_3_NAME]` | Third module name | - | ⚪ |

### Confidence & Validation

| Placeholder | Description | Example Values | Default | Required |
|------------|-------------|----------------|---------|----------|
| `[DEFAULT_CONFIDENCE_THRESHOLD]` | Default confidence threshold | 70, 80, 90 | 80 | ✅ |
| `[HIGH_THRESHOLD]` | High confidence threshold | 85, 90, 95 | 90 | ✅ |
| `[MED_HIGH_THRESHOLD]` | Medium-high threshold | 80, 85, 89 | 89 | ✅ |
| `[MED_LOW_THRESHOLD]` | Medium-low threshold | 60, 70, 75 | 70 | ✅ |
| `[LOW_THRESHOLD]` | Low confidence threshold | 50, 60, 70 | 70 | ✅ |
| `[REQUIRE_2FA_FOR_CRITICAL]` | Require 2FA for critical actions | true, false | false | ✅ |

---

## UI/UX Design

| Placeholder | Description | Example Values | Default | Required |
|------------|-------------|----------------|---------|----------|
| `[DESIGN_STYLE]` | Design style | glassmorphic, neumorphic, minimal | glassmorphic | ✅ |
| `[COLOR_PALETTE]` | Color palette | gradient #143795 → #E4930F | - | ✅ |
| `[PRIMARY_LANGUAGE]` | Primary language | FR, EN, DE, ES | EN | ✅ |
| `[SECONDARY_LANGUAGES]` | Additional languages | EN, DE, ES, IT | - | ⚪ |

---

## Security & Compliance

### Authentication

| Placeholder | Description | Example Values | Required |
|------------|-------------|----------------|----------|
| `[OAUTH_PROVIDERS]` | OAuth providers | Google, GitHub, Microsoft | ⚪ |
| `[CUSTOM_ROLES]` | Custom user roles | Manager, Analyst, Contributor | ⚪ |
| `[JWT_EXPIRY]` | JWT token expiry | 7d, 30d, 1h | ✅ |

### Sandbox & Execution

| Placeholder | Description | Example Values | Default | Required |
|------------|-------------|----------------|---------|----------|
| `[WASM_MEMORY_LIMIT]` | WASM memory limit | 128MB, 256MB, 512MB | 128MB | ✅ |
| `[WASM_TIMEOUT]` | WASM execution timeout | 30s, 60s, 120s | 30s | ✅ |
| `[FIRECRACKER_MEMORY]` | Firecracker VM memory | 256MB, 512MB, 1GB | 512MB | ✅ |
| `[FIRECRACKER_VCPUS]` | Firecracker vCPUs | 1, 2, 4 | 1 | ✅ |
| `[DOCKER_MEMORY]` | Docker memory limit | 256m, 512m, 1g | 256m | ✅ |
| `[DOCKER_CPUS]` | Docker CPU limit | 0.5, 1, 2 | 0.5 | ✅ |
| `[SANDBOX_TYPE_DEFAULT]` | Default sandbox type | auto, wasm, firecracker, docker | auto | ✅ |
| `[RISK_THRESHOLD]` | Code risk threshold | 70, 80, 90 | 80 | ✅ |
| `[AGENT_TIMEOUT]` | Agent execution timeout | 5, 10, 15 | 5 | ✅ |

### Retry & Resilience

| Placeholder | Description | Example Values | Default | Required |
|------------|-------------|----------------|---------|----------|
| `[RETRY_SEQUENCE]` | Retry backoff sequence | 1s, 2s, 4s, 8s, 16s | 1s, 2s, 4s, 8s | ✅ |
| `[CHECKPOINT_PATTERN]` | Checkpoint pattern | AI_CHECKPOINT.json, .snapshots/ | AI_CHECKPOINT.json | ✅ |

### Compliance

| Placeholder | Description | Example Values | Default | Required |
|------------|-------------|----------------|---------|----------|
| `[COMPLIANCE_STANDARDS]` | Compliance standards | SOC2/ISO27001, HIPAA, PCI-DSS | - | ⚪ |
| `[RETENTION_DAYS]` | Data retention period | 30, 90, 365 | 90 | ✅ |
| `[CAPTCHA_PROVIDER]` | CAPTCHA provider | Cloudflare Turnstile, hCaptcha | - | ⚪ |

---

## Database & LLM

### Embeddings & pgvector

| Placeholder | Description | Example Values | Default | Required |
|------------|-------------|----------------|---------|----------|
| `[EMBEDDING_DIMENSIONS]` | Vector dimensions | 384, 768, 1536, 3072 | 384 | ✅ |
| `[EMBEDDING_PROVIDER]` | Embedding provider | local, openai, custom | local | ✅ |
| `[SIMILARITY_THRESHOLD]` | Similarity threshold | 0.6, 0.7, 0.8 | 0.7 | ✅ |
| `[SEARCH_LIMIT]` | Search result limit | 5, 10, 20 | 10 | ✅ |
| `[LOCAL_EMBEDDING_MODEL]` | Local embedding model | all-MiniLM-L6-v2, all-mpnet-base-v2 | all-MiniLM-L6-v2 | ✅ |
| `[LOCAL_DIMENSIONS]` | Local model dimensions | 384, 768 | 384 | ✅ |
| `[OPENAI_EMBEDDING_MODEL]` | OpenAI model name | text-embedding-3-small | - | ⚪ |
| `[OPENAI_DIMENSIONS]` | OpenAI dimensions | 1536, 3072 | 1536 | ⚪ |

### LLM Integration

| Placeholder | Description | Example Values | Required |
|------------|-------------|----------------|----------|
| `[LOCAL_LLM_PROVIDERS]` | Local LLM providers | Ollama API, llama.cpp, GPT4All | ⚪ |
| `[API_LLM_PROVIDERS]` | API LLM providers | OpenAI SDK, Anthropic SDK, Gemini | ⚪ |
| `[LLM_ORCHESTRATION]` | LLM orchestration framework | LangChain, LlamaIndex, Haystack | ⚪ |
| `[LLM_CACHE_TTL]` | LLM cache TTL | 12h, 24h, 7d | 24h | ✅ |
| `[CUSTOM_LOCAL_MODELS]` | Custom local models | - | ⚪ |
| `[CUSTOM_API_PROVIDERS]` | Custom API providers | - | ⚪ |

---

## Deployment

### Docker

| Placeholder | Description | Example Values | Default | Required |
|------------|-------------|----------------|---------|----------|
| `[BASE_IMAGE]` | Docker base image | node:20-alpine, bun:1-alpine | node:20-alpine | ✅ |
| `[INSTALL_PG_CLIENT]` | PostgreSQL client install | apk add postgresql-client | - | ⚪ |
| `[MULTI_TENANT_DEFAULT]` | Multi-tenant default | true, false | false | ✅ |
| `[WORKER_REPLICAS]` | Worker replica count | 1, 2, 4 | 2 | ✅ |

### Umbrel

| Placeholder | Description | Example Values | Required |
|------------|-------------|----------------|----------|
| `[UMBREL_CATEGORY]` | Umbrel app category | automation, productivity, ai | ✅ |
| `[FEATURE_1]`, `[FEATURE_2]`, etc. | Key features | AI-powered triage, Semantic search | ✅ |
| `[RELEASE_NOTES]` | Release notes | Initial release, Bug fixes | ✅ |
| `[SUBMITTER_NAME]` | Umbrel submitter name | Your Name | ⚪ |

### Installation Scripts

| Placeholder | Description | Example Values | Required |
|------------|-------------|----------------|----------|
| `[VERSION_CHECK_COMMAND]` | Version check command | NODE_VERSION=$(node -v \| cut -dv -f2) | ✅ |
| `[VERSION_VAR]` | Version variable | $NODE_VERSION | ✅ |
| `[MIN_VERSION_NUMBER]` | Minimum version number | 20, 18, 1 | ✅ |
| `[RUNTIME_EXEC_PATH]` | Runtime executable path | /usr/bin/node, /usr/local/bin/bun | ✅ |
| `[RUNTIME_CHECK_COMMAND]` | Runtime check (PowerShell) | node -v, bun -v | ✅ |

### Email Configuration

| Placeholder | Description | Example Values | Default | Required |
|------------|-------------|----------------|---------|----------|
| `[SMTP_HOST]` | SMTP server host | smtp.gmail.com, smtp.sendgrid.net | smtp.gmail.com | ⚪ |
| `[SMTP_PORT]` | SMTP port | 587, 465, 25 | 587 | ⚪ |
| `[SMTP_USER]` | SMTP username | your-email@domain.com | - | ⚪ |
| `[SMTP_PASS]` | SMTP password | your-password | - | ⚪ |

---

## Testing & Quality

### Testing

| Placeholder | Description | Example Values | Default | Required |
|------------|-------------|----------------|---------|----------|
| `[TEST_COVERAGE]` | Minimum test coverage | 70%, 80%, 90% | 80% | ✅ |
| `[TEST_FRAMEWORK]` | Unit test framework | Vitest, Jest, Pytest, Go test | Vitest | ✅ |
| `[TEST_LIBRARY]` | Frontend test library | React Testing Library, Vue Testing Library | React Testing Library | ✅ |
| `[INTEGRATION_TEST_TOOL]` | Integration test tool | Supertest, httpx, net/http/httptest | Supertest | ✅ |
| `[E2E_FRAMEWORK]` | E2E testing framework | Playwright, Cypress, Puppeteer | Playwright | ✅ |
| `[VISUAL_TEST_TOOL]` | Visual regression tool | Chromatic, Percy, BackstopJS | Chromatic | ⚪ |
| `[LOAD_TEST_TOOL]` | Load testing tool | k6, Artillery, Locust | k6 | ⚪ |

### CI/CD

| Placeholder | Description | Example Values | Default | Required |
|------------|-------------|----------------|---------|----------|
| `[CI_PLATFORM]` | CI/CD platform | GitHub Actions, GitLab CI, CircleCI | GitHub Actions | ✅ |
| `[CONTAINER_REGISTRY]` | Container registry | GitHub Container Registry, Docker Hub | GitHub Container Registry | ✅ |
| `[REGISTRY_URL]` | Registry URL | ghcr.io, docker.io, registry.gitlab.com | ghcr.io | ✅ |
| `[REGISTRY_TOKEN]` | Registry token secret | GITHUB_TOKEN, DOCKERHUB_TOKEN | GITHUB_TOKEN | ✅ |

### Quality Gates

| Placeholder | Description | Example Values | Default | Required |
|------------|-------------|----------------|---------|----------|
| `[LINTER]` | Code linter | ESLint, Pylint, golangci-lint | ESLint | ✅ |
| `[FORMATTER]` | Code formatter | Prettier, Black, gofmt | Prettier | ✅ |
| `[FORMAT_RULES]` | Formatting rules | single quotes, 2 spaces, trailing comma | - | ⚪ |
| `[GIT_HOOKS]` | Git hooks tool | Husky, pre-commit, lefthook | Husky | ⚪ |
| `[STAGED_FILES_TOOL]` | Staged files linter | lint-staged, pre-commit | lint-staged | ⚪ |
| `[LANGUAGE_TYPE_SYSTEM]` | Type system | mypy + Pydantic, native | - | ⚪ |
| `[SECURITY_SCANNER_1]` | Security scanner | Snyk, npm audit, Safety | Snyk | ⚪ |
| `[COVERAGE_SERVICE]` | Coverage service | Codecov, Coveralls, CodeClimate | Codecov | ⚪ |
| `[COVERAGE_DROP_THRESHOLD]` | Coverage drop threshold | 1%, 2%, 5% | 2% | ✅ |

---

## Monitoring

### Logging

| Placeholder | Description | Example Values | Default | Required |
|------------|-------------|----------------|---------|----------|
| `[LOGGING_LIBRARY]` | Logging library | Pino, Winston, Loguru, slog | Pino | ✅ |
| `[LOGGER]` | Logger instance name | pino, logger | pino | ✅ |
| `[LOG_LEVEL]` | Log level | debug, info, warn, error | info | ✅ |
| `[LOG_MAX_SIZE]` | Max log file size | 50MB, 100MB, 200MB | 100MB | ✅ |
| `[LOG_RETENTION_DAYS]` | Log retention | 7, 30, 90 | 30 | ✅ |
| `[SENSITIVE_FIELDS]` | Sensitive field names | secret, apiKey, token, password | - | ⚪ |

### Metrics & Alerting

| Placeholder | Description | Example Values | Default | Required |
|------------|-------------|----------------|---------|----------|
| `[ENTITY]` | Main entity name | Workflow, Task, Document | - | ✅ |
| `[ENTITY_ID]` | Entity ID field | workflowId, taskId, documentId | - | ✅ |
| `[ENTITIES]` | Entity plural | workflows, tasks, documents | - | ✅ |
| `[ACTION_NAME]` | Action name | move_file, classify_email | - | ⚪ |
| `[ERROR_RATE_THRESHOLD]` | Error rate threshold | 0.05, 0.1, 0.15 | 0.05 | ✅ |
| `[ERROR_RATE_THRESHOLD_PERCENT]` | Error rate % | 5%, 10%, 15% | 5% | ✅ |
| `[QUEUE_THRESHOLD]` | Queue size threshold | 50, 100, 200 | 100 | ✅ |
| `[LLM_LATENCY_THRESHOLD]` | LLM latency threshold (s) | 3, 5, 10 | 5 | ✅ |
| `[CUSTOM_METRICS]` | Custom Prometheus metrics | - | ⚪ |
| `[CUSTOM_PANELS]` | Custom Grafana panels | - | ⚪ |
| `[CUSTOM_ALERT_RULES]` | Custom alert rules | - | ⚪ |
| `[CUSTOM_NOTIFICATION_CHANNELS]` | Custom notification channels | - | ⚪ |

---

## Extensibility

### Plugins

| Placeholder | Description | Example Values | Required |
|------------|-------------|----------------|----------|
| `[SERVER_INSTANCE]` | Server instance type | FastifyInstance, Express, HonoApp | ✅ |
| `[EXAMPLE_PLUGIN_ID]` | Example plugin ID | email-spam-filter, data-extractor | ⚪ |
| `[EXAMPLE_PLUGIN_NAME]` | Example plugin name | Email Spam Filter, Data Extractor | ⚪ |
| `[EXAMPLE_PLUGIN_DESCRIPTION]` | Plugin description | Filter spam emails using ML | ⚪ |
| `[PLUGIN_AUTHOR]` | Plugin author | Your Name | ⚪ |
| `[EXAMPLE_AGENT]` | Example agent class | SpamFilterAgent, DataExtractorAgent | ⚪ |
| `[CONFIG_LABEL]` | Config UI label | Spam Threshold, Extraction Mode | ⚪ |
| `[INPUT_TYPE]` | Input field type | range, text, select | ⚪ |
| `[INPUT_MIN]` | Input minimum value | 0, 10, 50 | ⚪ |
| `[INPUT_MAX]` | Input maximum value | 100, 200, 1000 | ⚪ |
| `[CONFIG_KEY]` | Config object key | threshold, mode, confidence | ⚪ |
| `[PLUGIN_REPO_URL]` | Plugin repository URL | https://github.com/... | ⚪ |
| `[CONFIG_PARAMS]` | Configuration parameters | - | ⚪ |

### API & Webhooks

| Placeholder | Description | Example Values | Required |
|------------|-------------|----------------|----------|
| `[MAIN_ENTITY]` | Main API entity | Workflow, Document, Project | ✅ |
| `[MAIN_ENTITY_PLURAL]` | Entity plural | workflows, documents, projects | ✅ |
| `[ACTION]` | API action | execute, analyze, process | ⚪ |
| `[ACTION_DESCRIPTION]` | Action description | Execute workflow, Analyze document | ⚪ |
| `[ACTION_OPTIONS]` | Action options | dryRun, detailed, async | ⚪ |
| `[OPTION_TYPE]` | Option type | boolean, string, number | ⚪ |
| `[OPTION_DEFAULT]` | Option default value | false, "standard", 0 | ⚪ |
| `[CUSTOM_QUERY_PARAMS]` | Custom query parameters | - | ⚪ |
| `[CUSTOM_API_ENDPOINTS]` | Custom API endpoints | - | ⚪ |
| `[API_DESCRIPTION]` | API description | - | ⚪ |
| `[CUSTOM_FILTERS]` | Custom webhook filters | - | ⚪ |
| `[CUSTOM_WEBHOOK_EVENTS]` | Custom webhook events | - | ⚪ |
| `[ACTION_TYPE]` | Webhook action type | - | ⚪ |
| `[ACTION_FIELD_1]` | Action field 1 | - | ⚪ |
| `[VALUE_1]` | Action value 1 | - | ⚪ |
| `[PREVIEW_FIELD]` | Preview field name | - | ⚪ |
| `[PREVIEW_VALUE]` | Preview value | - | ⚪ |

---

## Custom Sections

### Connectors

| Placeholder | Description | Example Values | Required |
|------------|-------------|----------------|----------|
| `[CUSTOM_STORAGE]` | Custom storage connectors | Backblaze B2, Wasabi | ⚪ |
| `[CUSTOM_EMAIL]` | Custom email connectors | FastMail, ProtonMail | ⚪ |
| `[CUSTOM_MESSAGING]` | Custom messaging connectors | Matrix, Rocket.Chat | ⚪ |
| `[CUSTOM_DB]` | Custom database connectors | CouchDB, Cassandra | ⚪ |
| `[CUSTOM_TICKETING]` | Custom ticketing connectors | ServiceNow, Zendesk | ⚪ |
| `[CUSTOM_CLOUD]` | Custom cloud connectors | DigitalOcean, Linode | ⚪ |
| `[CUSTOM_VISION]` | Custom vision connectors | Custom OCR API | ⚪ |
| `[CUSTOM_CRM]` | Custom CRM connectors | Zoho, SugarCRM | ⚪ |
| `[CUSTOM_EMBEDDING]` | Custom embedding provider | Custom API | ⚪ |

### Architecture

| Placeholder | Description | Example Values | Required |
|------------|-------------|----------------|----------|
| `[REVERSE_PROXY]` | Reverse proxy | Nginx, Traefik, Caddy | ⚪ |
| `[MESSAGE_QUEUE]` | Message queue system | Redis Pub/Sub, RabbitMQ, NATS | ⚪ |
| `[RATE_LIMIT]` | Rate limit (req/min) | 60, 100, 200 | 100 | ⚪ |
| `[CDN_PROVIDER]` | CDN provider | Cloudflare, BunnyCDN, jsDelivr | ⚪ |

### Documentation

| Placeholder | Description | Example Values | Required |
|------------|-------------|----------------|----------|
| `[RECOMMENDED_FOLDER_STRUCTURE]` | Folder structure | - | ⚪ |
| `[CUSTOM_GUIDE_1]` | Custom guide 1 name | Integration Guide | ⚪ |
| `[CUSTOM_GUIDE_2]` | Custom guide 2 name | Advanced Configuration | ⚪ |
| `[CUSTOM_CODE_COMPONENTS]` | Custom code components | - | ⚪ |
| `[CUSTOM_PLATFORMS]` | Custom deployment platforms | - | ⚪ |
| `[DOC_STANDARD]` | Documentation standard | TSDoc, JSDoc, Docstring | ⚪ |
| `[DOC_COMMENT_STYLE]` | Comment style | - | ⚪ |
| `[ID_FORMAT]` | ID format | UUID format, nanoid, ULID | ⚪ |
| `[INPUT_EXAMPLE]` | Input example | { file: 'path/to/file.pdf' } | ⚪ |
| `[DOCUMENTATION_URL]` | Documentation URL | - | ⚪ |
| `[GRAPHQL_IF_USED]` | GraphQL note if used | + GraphQL | ⚪ |
| `[SEO_IF_PUBLIC]` | SEO note if public | true | ⚪ |
| `[LANGUAGE]` | Programming language | TypeScript, Python, Go | ⚪ |

### Environment & Configuration

| Placeholder | Description | Example Values | Required |
|------------|-------------|----------------|----------|
| `[CUSTOM_ENV_SECTION]` | Custom env section | - | ⚪ |
| `[CUSTOM_ENV_VARS]` | Custom env variables | - | ⚪ |
| `[CUSTOM_LLM_API_KEYS]` | Custom LLM API keys | CUSTOM_AI_KEY= | ⚪ |
| `[BILLING_PROVIDER]` | Billing provider | Stripe, Paddle, LemonSqueezy | ⚪ |
| `[USE_CASE]` | Example use case | trier mes factures | ⚪ |

---

## 📝 Notes

### Required vs Optional

- ✅ **Required** - Must be filled for template to work correctly
- ⚪ **Optional** - Can be left empty or removed if not applicable

### Naming Conventions

- Use `UPPERCASE_WITH_UNDERSCORES` format
- Keep names descriptive and consistent
- Prefix related placeholders (e.g., `MODULE_1_`, `MODULE_2_`)

### Best Practices

1. **Fill all required placeholders** before generating
2. **Use validation script** to check completeness: `./scripts/validate-placeholders.sh`
3. **Keep consistency** - if you use `[PROJECT_NAME]` as "Klaro", use "klaro" for `[PROJECT_ID_LOWERCASE]`
4. **Document custom values** in your project's README
5. **Test generation** with Phase 1 only before full generation

---

**Total: 150+ placeholders**

For interactive placeholder filling, use:

```bash
./scripts/generate-project.sh
```

For validation:

```bash
./scripts/validate-placeholders.sh my-project-prompt.md
```