# 🏗️ Data Architect Template

> The ultimate template to generate production-ready Data/AI architectures with Claude Code or any capable LLM code generation model.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)
[![Made with ❤️ by Krigs](https://img.shields.io/badge/Made%20with%20%E2%9D%A4%EF%B8%8F%20by-Krigs-red)](https://github.com/Krigsexe)
![Banner](assets/banner.png)

---

## 🎯 What Is This?

A **Claude Code Master Template** that automatically generates a complete, production-ready architecture for any Data/AI project in 5 phases:

✅ **Complete Backend** (Fastify/Express + PostgreSQL + Redis + BullMQ)
✅ **Modern Frontend** (React/Vue/Svelte + TailwindCSS + Vite)
✅ **AI Agents** with Human-in-the-loop & Confidence Scoring
✅ **Semantic Search** via pgvector (embeddings)
✅ **Secure Sandbox** (WASM + Firecracker + Docker)
✅ **Automated Testing** (Unit + Integration + E2E with Playwright)
✅ **CI/CD Pipeline** (Full GitHub Actions Workflow)
✅ **Monitoring** (Prometheus + Grafana + Structured Logs)
✅ **Multi-Platform Deployment** (Docker, Umbrel, Kubernetes, Native)
✅ **Exhaustive Documentation** (42 Deliverables)

**The Result:** A project ready for production deployment with enterprise-grade architecture.

---

## 🚀 Quick Start (5 Minutes)

### Step 1: Download the Template
```bash
# Clone the repository
git clone [https://github.com/Krigsexe/Data-Architect-Template.git](https://github.com/Krigsexe/Data-Architect-Template.git)
cd Data-Architect-Template
# Copy the template
cp templates/master-template.md my-project-prompt.md
````

### Step 2: Customize (Find/Replace)

Open `my-project-prompt.md` and replace the placeholders:

```text
[PROJECT_NAME] → MySuperProject
[DOMAIN_DESCRIPTION] → Intelligent AI-augmented content management
[DEVELOPER_NAME] → Julien Gelée (Krigs)
[GITHUB_USER] → Krigsexe
[PRIMARY_LANGUAGE] → EN
[BACKEND_FRAMEWORK] → Fastify
[FRONTEND_FRAMEWORK] → React 18+
... (see docs/customization-guide.md for the complete list)
```

💡 **Tip:** Use the [filling checklist](https://www.google.com/search?q=%23-filling-checklist) at the bottom of the template.

### Step 3: Generate with Claude Code

1.  Open Claude Code (or Claude via API)
2.  Copy-paste the customized prompt
3.  Launch **Phase 1 Only** (Structure + Config)
4.  Validate before continuing to Phases 2→5

<!-- end list -->

```text
Prompt: "Start with Phase 1 (Initialization) only. Wait for my Go before continuing."
```

### Step 4: Deploy 🎉

```bash
cd [your-generated-project]
docker-compose up -d
# Access: http://localhost:3000
```

-----

## 📚 Table of Contents

  - [🎯 What Is This?](https://www.google.com/search?q=%23-what-is-this)
  - [🚀 Quick Start](https://www.google.com/search?q=%23-quick-start-5-minutes)
  - [✨ Key Features](https://www.google.com/search?q=%23-key-features)
  - [🏗️ Architecture](https://www.google.com/search?q=%23%EF%B8%8F-architecture)
  - [📖 Documentation](https://www.google.com/search?q=%23-documentation)
  - [🎨 Project Examples](https://www.google.com/search?q=%23-project-examples)
  - [🛠️ Customization](https://www.google.com/search?q=%23%EF%B8%8F-customization)
  - [🧪 Validation & Testing](https://www.google.com/search?q=%23-validation--testing)
  - [🤝 Contribution](https://www.google.com/search?q=%23-contribution)
  - [📜 License](https://www.google.com/search?q=%23-license)
  - [🙏 Acknowledgements](https://www.google.com/search?q=%23-acknowledgements)

-----

## ✨ Key Features

### 🧠 Modern AI Architecture

  - **Human-in-the-loop**: Human validation for low-confidence actions.
  - **Confidence Scoring**: Automatic routing based on confidence level (0-100%).
  - **Semantic Search**: pgvector + embeddings for RAG and long-term memory.
  - **Multi-LLM**: Support for local (Ollama, Llama) and API (OpenAI, Claude, Gemini).
  - **Intelligent Fallback**: Automatic backup chain (LLM1 → LLM2 → LLM3).

### 🔒 Production-Grade Security

  - **Multi-level Sandbox**: WASM (fast) → Firecracker (Linux KVM) → Docker (fallback).
  - **OS Auto-detection**: Automatic choice of optimal sandbox based on platform.
  - **End-to-End Encryption**: TLS 1.3 (in transit) + AES-256 (at rest).
  - **Granular RBAC**: Role and permission management.
  - **Full Audit Trail**: Immutable logs of all actions.

### 🎨 Premium UI/UX

  - **Modern Design System**: Glassmorphic/Neumorphic with dark/light mode.
  - **Visual Workflow Editor**: Drag-and-drop with ReactFlow.
  - **Validation Interface**: "Tinder Swipe" style for quick validation.
  - **Responsive**: Mobile-first guaranteed.
  - **Accessibility**: WCAG 2.1 AA compliant.

### 📊 Monitoring & Observability

  - **Prometheus + Grafana**: Real-time metrics + pre-configured dashboards.
  - **Structured Logs**: JSON format with correlation IDs.
  - **Alerting**: Multi-channel webhooks (Slack, Discord, Email).
  - **Tracing**: OpenTelemetry for distributed debugging.

### 🚢 Universal Deployment

  - **Docker Compose**: One-click local deployment.
  - **Umbrel/CasaOS**: App store ready for self-hosting.
  - **Kubernetes**: Production-ready manifests.
  - **Native Scripts**: Linux installation (bash) + Windows (PowerShell).

### 🧪 Automated Testing

  - **Unit tests**: Vitest/Jest with \>80% coverage.
  - **Integration tests**: API + Database + Queue.
  - **E2E tests**: Playwright multi-browser.
  - **Visual tests**: Chromatic for UI regressions.
  - **Load tests**: k6 for scalability assessment.

-----

## 🏗️ Architecture

### Principle: "Single-Tenant by Default, Multi-Tenant Ready"

The template generates a **modular** architecture that operates in two modes:

**Community Mode (Single-Tenant)**

  - Single user or small team.
  - Lightweight local deployment (2GB RAM, 10GB disk).
  - Simplified database.

**Enterprise Mode (Multi-Tenant)**

  - SaaS Architecture with isolation by `tenant_id`.
  - SAML SSO, quotas, billing.
  - Horizontal scalability.

**Switching is done via a single environment variable:** `MULTI_TENANT=true`

### Default Technical Stack

| Component | Technology | Rationale |
| :--- | :--- | :--- |
| **Backend** | Fastify + TypeScript | Performance + Type-safety |
| **Frontend** | React 18 + Vite | Mature ecosystem + Ultra-fast HMR |
| **Database** | PostgreSQL 15 + pgvector | Relational + Semantic Search |
| **Cache** | Redis 7 | Sessions + Queue + Rate Limiting |
| **Queue** | BullMQ | Async jobs + Automatic retry |
| **LLM** | Ollama (Local) + OpenAI/Claude (API) | Flexibility + Privacy |
| **Monitoring** | Prometheus + Grafana | Industry Standard |
| **Tests** | Vitest + Playwright | Speed + Stability |

**All components are customizable via placeholders.**

### Architecture Diagram

```text
┌─────────────────┐
│ API Gateway │ (Nginx/Traefik)
└────────┬────────┘
│
┌────┴────┐
│ │
┌───▼────┐ ┌─▼──────────┐
│ Web │ │ Orchestrator│ (Workflow Engine)
│ UI │ │ Service │
└────────┘ └─────┬───────┘
│
┌────┴──────┐
│ │
┌────▼────┐ ┌───▼─────┐
│ Worker │ │ Worker │ (Agent Pool)
│ Pool │ │ Pool │
└────┬────┘ └────┬────┘
│ │
┌────▼───────────▼────┐
│ Message Queue │ (Redis/RabbitMQ)
└─────────────────────┘
│
┌────▼────┐
│ DB │ (PostgreSQL + pgvector)
└─────────┘
```

-----

## 📖 Documentation

The complete documentation is located in [`docs/`](https://www.google.com/search?q=docs/):

  - **[Getting Started](https://www.google.com/search?q=docs/getting-started.md)** - Installation and first project.
  - **[Architecture Decisions](https://www.google.com/search?q=docs/architecture.md)** - ADRs and technical justifications.
  - **[Customization Guide](https://www.google.com/search?q=docs/customization-guide.md)** - How to personalize each section.
  - **[Placeholders Reference](https://www.google.com/search?q=templates/placeholders-reference.md)** - Complete list of 150+ placeholders.
  - **[FAQ](https://www.google.com/search?q=docs/faq.md)** - Frequently Asked Questions.

-----

## 🎨 Project Examples

### Klaro - Multi-Domain Intelligent Triage

**Domain:** Triage Automation (files, emails, photos, tickets)
**Stack:** Node.js + Fastify + React + PostgreSQL + Redis
**Specific Features:**

  - 5 Agents (files, emails, photos, tickets, API)
  - 30+ Connectors (Drive, Slack, IMAP, S3, etc.)
  - "Swipe" validation interface for uncertain actions
    👉 [See the complete prompt](https://www.google.com/search?q=docs/examples/klaro-example.md)

### SmartCRM - AI-Augmented CRM

**Domain:** Customer Relationship Management with automatic enrichment
**Stack:** Bun + Hono + Vue 3 + PostgreSQL + Redis
**Specific Features:**

  - Automatic lead scoring
  - Personalized AI email sequences
  - Data enrichment via external APIs
    👉 [See the complete prompt](https://www.google.com/search?q=docs/examples/crm-example.md)

### DataFlow - AI Analytics Pipeline

**Domain:** ETL and predictive data analysis
**Stack:** Python + FastAPI + Svelte + PostgreSQL + Redis
**Specific Features:**

  - Multi-source data extraction
  - Anomaly detection
  - Automated report generation
    👉 [See the complete prompt](https://www.google.com/search?q=docs/examples/analytics-example.md)

**🌟 Created a project with this template?** [Share it here\!](https://www.google.com/search?q=https://github.com/Krigsexe/Data-Architect-Template/issues/new%3Ftemplate%3Dproject_showcase.md)

-----

## 🛠️ Customization

### Placeholders to Fill (Checklist)

The template contains **150+ placeholders** `[LIKE_THIS]` to personalize.

**Essentials (Minimum Viable):**

```text
✅ Project Identity
[PROJECT_NAME] → Ex: Klaro
[DOMAIN_DESCRIPTION] → Ex: multi-domain intelligent triage
[DEVELOPER_NAME] → Ex: Julien Gelée (Krigs)
[GITHUB_USER] → Krigsexe
✅ Technical Stack
[BACKEND_FRAMEWORK] → Ex: Fastify
[FRONTEND_FRAMEWORK] → Ex: React 18+
[ORM_CHOICE] → Ex: Prisma
✅ Configuration
[APP_PORT] → Ex: 3000
[PRIMARY_LANGUAGE] → Ex: EN
[DEFAULT_CONFIDENCE_THRESHOLD] → Ex: 80
```

**Optional (For Advanced Customization):**

```text
🎨 UI/UX
[COLOR_PALETTE] → Ex: gradient #143795 → #E4930F
[DESIGN_STYLE] → Ex: glassmorphic
🔧 Business Modules
[MODULE_1_NAME] → Ex: File Triage
[MODULE_1_DESCRIPTION] → Ex: AI renaming, classification...
🔌 Custom Connectors
[CUSTOM_STORAGE] → Ex: Backblaze B2
[CUSTOM_MESSAGING] → Ex: Matrix
📊 Custom Monitoring
[CUSTOM_METRICS] → Ex: specific business KPIs
```

👉 [Complete list with descriptions](https://www.google.com/search?q=templates/placeholders-reference.md)

### Helper Tools

```text
**Validation Script:**
./scripts/validate-placeholders.sh my-project-prompt.md
# Verifies that all essential placeholders are filled

**Interactive Generation:**
./scripts/generate-project.sh
# Interactive wizard to fill placeholders step-by-step
```

-----

## 🧪 Validation & Testing

### Before Generating with Claude Code

1.  **Validate Placeholders**: `./scripts/validate-placeholders.sh`
2.  **Verify Consistency**: Ensure the chosen stack is compatible (e.g., Node.js + Prisma)
3.  **Test Phase 1 Only**: Generate structure before the full code

### After Generation

1.  **Run Tests**: `npm test` (must pass \>80% coverage)
2.  **Verify Build**: `npm run build` (no TypeScript errors)
3.  **Test Docker**: `docker-compose up` (healthchecks pass)
4.  **Verify Security**: `npm audit` + Snyk scan

-----

## 🤝 Contribution

Contributions are welcome\! 🎉

### How to Contribute?

1.  **Fork** the repository
2.  **Create a branch**: `git checkout -b feature/amazing-feature`
3.  **Commit**: `git commit -m 'Add: Amazing feature'`
4.  **Push**: `git push origin feature/amazing-feature`
5.  **Open a Pull Request**

### Code Guidelines

#### Markdown Structure

  - Use `#` for top-level headings (never `##` at the first level)
  - Separate sections with `---`
  - Indent lists with 2 spaces
  - Use triple backtick code fences ` ``` `

#### Placeholders

  - Format: `[PLACEHOLDER_NAME]` (uppercase, underscores)
  - Always document in `templates/placeholders-reference.md`
  - Provide example value in comments
  - Consistency: If `[BACKEND_FRAMEWORK]` is used, always use the same placeholder

#### Documentation

  - Add concrete examples in `docs/examples/`
  - Update `README.md` if adding a major feature
  - Document decisions in `docs/architecture.md` if changing the structure

#### Tests

  - Test generation with Claude Code before PR
  - Verify that placeholders are consistent
  - Ensure all links work

### Types of Contributions Sought

#### 🌟 Highly Appreciated

  - **New Project Examples** (Healthcare, Fintech, E-commerce, etc.)
  - **Translations** (EN, DE, ES, IT, ZH, etc.)
  - **Utility Scripts** (validators, generators, formatters)
  - **Documentation Improvements** (clarifications, typos, examples)

#### ✅ Welcome

  - **New placeholders** for supporting additional technologies
  - **Template Optimizations** (structure, clarity)
  - **Bug Fixes** (broken placeholders, inconsistencies)

#### ⚠️ To Discuss First (Open an Issue)

  - **Major Architectural Changes**
  - **Complete Section Refactoring**
  - **Adding External Dependencies**

### Style Guide

#### Commits

Format: `Type: Short description`
**Types:**

  - `Add:` New feature
  - `Fix:` Bug fix
  - `Docs:` Documentation only
  - `Style:` Formatting (no code change)
  - `Refactor:` Refactoring (no new feature)
  - `Test:` Adding tests
  - `Chore:` Maintenance (deps, config)

**Examples:**

```text
Add: Support Bun runtime backend
Fix: Placeholder [APP_PORT] missing in docker-compose
Docs: Add Python FastAPI example
Refactor: Simplify pgvector configuration section
```

#### Pull Requests

**Title:** Same format as commits
**Description:**

  - Explain **why** (not just **what**)
  - Link relevant issues (`Closes #123`)
  - Add screenshots if UI changes
  - Mention breaking changes if applicable

### Review Process

1.  **Auto-checks**: Link validation, Markdown format
2.  **Maintainer review**: Verification of consistency with the project
3.  **Testing**: Template generation test with Claude Code
4.  **Merge**: If everything is OK, merge into `main`

**Timeline:** Generally within 48 hours for the first review.

### Becoming a Maintainer

If you contribute regularly and with quality, we may offer you the role of maintainer with:

  - Write access to the repository
  - Participation in architectural decisions
  - Mention in the README
    Contact **[@Krigsexe](https://github.com/Krigsexe)** if interested.

## Questions?

  - 💬 [GitHub Discussions](https://www.google.com/search?q=https://github.com/Krigsexe/Data-Architect-Template/discussions)
  - 📧 Email: [contact@proxitek.fr](mailto:contact@proxitek.fr)

### Networks

  - 🌐 **Website**: [solvin.ch](https://solvin.ch)
  - 🐱 **GitHub**: [@Krigsexe](https://github.com/Krigsexe)

-----

## ⭐ Star History

If this project helps you, don't forget to give it a ⭐\!
[](https://www.google.com/search?q=https://star-history.com/%23Krigsexe/Data-Architect-Template%26Date)

-----

**Made with ❤️ by [Krigs (Julien Gelée)](https://github.com/Krigsexe) – Make With Passion**
*"A good template is worth a thousand lines of boilerplate code."*

```
```
