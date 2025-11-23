# 🚀 Getting Started

Welcome to the Data Architect Template! This guide will help you create your first production-ready AI/Data project in minutes.

---

## 📚 Table of Contents

- [Prerequisites](#prerequisites)
- [Quick Start (5 Minutes)](#quick-start-5-minutes)
- [Step-by-Step Guide](#step-by-step-guide)
- [Next Steps](#next-steps)
- [Troubleshooting](#troubleshooting)

---

## Prerequisites

**Before you begin, ensure you have:**

- **Claude Code** or any LLM code generation model (GPT-4, Gemini, etc.)
- **Git** (for cloning the repository)
- **Text Editor** (VS Code, Sublime, Vim, etc.)
- **Basic knowledge** of:
  - Your chosen tech stack (Node.js, Python, etc.)
  - Docker (optional but recommended)
  - Markdown syntax

**System Requirements:**

- 💻 **OS:** Windows, Linux, or macOS
- 💾 **RAM:** 4GB minimum (8GB recommended)
- 💾 **Disk:** 500MB for template + your project size

---

## Quick Start (5 Minutes)

### 1️⃣ Clone the Template

```bash
git clone https://github.com/Krigsexe/Data-Architect-Template.git
cd Data-Architect-Template
```

### 2️⃣ Copy and Customize

```bash
# Copy the master template
cp templates/master-template.md my-project.md

# Open in your editor
code my-project.md  # or vim, nano, etc.
```

### 3️⃣ Fill Placeholders

Replace all `[PLACEHOLDER]` values with your project details:

```markdown
[PROJECT_NAME] → MyAwesomeProject
[DEVELOPER_NAME] → John Doe
[GITHUB_USER] → johndoe
[BACKEND_FRAMEWORK] → Fastify
[FRONTEND_FRAMEWORK] → React 18+
...
```

**💡 Tip:** Use Find & Replace for faster filling.

**🔗 See:** [placeholders-reference.md](../templates/placeholders-reference.md) for complete list.

### 4️⃣ Validate

```bash
# Check that all essential placeholders are filled
./scripts/validate-placeholders.sh my-project.md
```

**Expected output:**

```
Filled: 8/8
Missing: 0
✅ All essential placeholders are filled!
```

### 5️⃣ Generate with Claude Code

1. Open **Claude Code** (or your LLM tool)
2. Copy-paste your customized template
3. Add this instruction:

```
Start with Phase 1 (Initialization) only.
Wait for my "Go" before continuing to Phase 2.
```

4. Review Phase 1 output (structure + config)
5. Type **"Go"** to proceed to Phase 2–5

**🎉 That's it!** Your production-ready project is generated.

---

## Step-by-Step Guide

### Detailed Workflow

#### **Step 1: Choose Your Approach**

You have **2 options**:

**Option A: Interactive Wizard** (✅ Recommended for beginners)

```bash
./scripts/generate-project.sh
```

This will:
- Ask you questions interactively
- Fill placeholders automatically
- Generate a customized template
- Validate automatically

**Option B: Manual Customization** (🔧 For advanced users)

1. Copy `templates/master-template.md`
2. Manually fill all `[PLACEHOLDERS]`
3. Run validation script

#### **Step 2: Fill Essential Placeholders**

**⚠️ Minimum Required (8 placeholders):**

| Category | Placeholder | Example Value |
|----------|-------------|---------------|
| **Identity** | `[PROJECT_NAME]` | Klaro |
| | `[DOMAIN_DESCRIPTION]` | intelligent file triage |
| **Developer** | `[DEVELOPER_NAME]` | John Doe |
| | `[GITHUB_USER]` | johndoe |
| **Stack** | `[BACKEND_FRAMEWORK]` | Fastify |
| | `[FRONTEND_FRAMEWORK]` | React 18+ |
| | `[ORM_CHOICE]` | Prisma |
| **Config** | `[APP_PORT]` | 3000 |

**💡 Optional but Recommended (20+ more):**

- `[DEFAULT_CONFIDENCE_THRESHOLD]` → 80
- `[NUM_AGENTS]` → 5
- `[PRIMARY_LANGUAGE]` → EN
- `[COLOR_PALETTE]` → gradient #143795 → #E4930F
- ...

🔗 **Full list:** [placeholders-reference.md](../templates/placeholders-reference.md)

#### **Step 3: Validate Your Template**

```bash
# Run validation
./scripts/validate-placeholders.sh my-project.md

# Expected output if OK
✅ Filled: 8/8
✅ Missing: 0
✅ All essential placeholders are filled!
```

**If validation fails:**

```
❌ Missing: [PROJECT_NAME]
❌ Missing: [GITHUB_USER]

Validation failed. Please fill all essential placeholders.
```

→ Go back to your template and fill missing placeholders.

#### **Step 4: Generate with LLM (Phase-by-Phase)**

**⚠️ IMPORTANT: Do NOT generate all 5 phases at once** (context window limit).

**Best Practice: Iterative Generation**

**Phase 1: Initialization**

```
Prompt to Claude Code:

"Start with Phase 1 (Initialization) only.
Generate:
1. Complete folder structure
2. docker-compose.yml with pgvector
3. Prisma schema with vector extension
4. README.md with badges
5. .env.example documented
6. package.json with scripts

Wait for my 'Go' before Phase 2."
```

✅ **Review Phase 1 output** (5-10 minutes)

- Check folder structure makes sense
- Verify docker-compose.yml has pgvector image
- Ensure .env.example has all variables

✅ **If satisfied:** Type **"Go to Phase 2"**

---

**Phase 2: Backend Core**

```
Prompt:

"Phase 2: Backend Core
Generate:
1. Fastify server configuration
2. Database setup (Prisma + pgvector)
3. JWT authentication + RBAC
4. BullMQ worker queue
5. Main API routes
6. Backend unit tests

Wait for 'Go' before Phase 3."
```

✅ **Review Phase 2 output**

- Test auth endpoints work
- Verify database migrations
- Check queue system setup

---

**Phase 3: Frontend Core**

```
Prompt:

"Phase 3: Frontend Core
Generate:
1. React 18 + Vite setup
2. Design system + components
3. Dashboard with metrics
4. ReactFlow workflow editor
5. Validation queue UI (swipe interface)
6. Playwright E2E tests

Wait for 'Go' before Phase 4."
```

✅ **Review Phase 3 output**

- Check UI renders correctly
- Test dark/light mode toggle
- Verify swipe interface works

---

**Phase 4: AI Engine + Agents**

```
Prompt:

"Phase 4: AI Engine + Agents
Generate:
1. Base Agent class
2. LLM integration (local + API)
3. pgvector + embeddings system
4. Confidence scoring logic
5. 5 agent implementations
6. WASM/Firecracker sandbox

Wait for 'Go' before Phase 5."
```

✅ **Review Phase 4 output**

- Test LLM connection (Ollama or API)
- Verify embeddings creation
- Check agent execution

---

**Phase 5: Connectors + Polish**

```
Prompt:

"Phase 5: Connectors + Polish (FINAL)
Generate:
1. 10+ connector implementations
2. Complete plugin system
3. Webhooks
4. Prometheus + Grafana monitoring
5. Backup/restore scripts
6. Full documentation (42 deliverables)
7. GitHub Actions CI/CD

This is the final phase."
```

✅ **Final Review**

- Run full test suite: `npm test`
- Build production: `npm run build`
- Test Docker deployment: `docker-compose up`

---

#### **Step 5: Deploy Your Project**

**Local Deployment (Docker):**

```bash
cd your-generated-project

# Start all services
docker-compose up -d

# Check healthchecks
docker-compose ps

# Access application
open http://localhost:3000
```

**Umbrel Deployment:**

```bash
# Copy to Umbrel apps directory
cp -r your-project ~/umbrel/apps/

# Install via Umbrel UI
# Navigate to App Store → Install
```

**Native Installation:**

```bash
# Linux
./scripts/install.sh

# Windows (PowerShell)
.\scripts\install.ps1
```

---

## Next Steps

### After Generation

**1️⃣ Configure Environment**

```bash
# Edit .env with your API keys
nano .env

# Add your LLM API keys
OPENAI_API_KEY=sk-...
ANTHROPIC_API_KEY=sk-ant-...
OLLAMA_URL=http://localhost:11434
```

**2️⃣ Setup Database**

```bash
# Run migrations
npm run migrate

# Seed sample data (optional)
npm run seed
```

**3️⃣ Customize & Extend**

- 🎨 Modify `design-system.css` for your brand colors
- 🤖 Add custom agents in `src/agents/`
- 🔌 Create new connectors in `src/connectors/`
- 📦 Build plugins in `plugins/`

**4️⃣ Learn More**

- 📚 [Architecture Guide](architecture.md)
- 🔧 [Customization Guide](customization-guide.md)
- ❓ [FAQ](faq.md)
- 🐞 [Troubleshooting](#troubleshooting)

---

## Troubleshooting

### Common Issues

#### ❌ "Placeholder validation failed"

**Problem:** You forgot to fill some essential placeholders.

**Solution:**

```bash
# Run validation to see which ones are missing
./scripts/validate-placeholders.sh my-project.md

# Fill the missing ones
# Re-run validation
```

---

#### ❌ "Claude Code truncated output"

**Problem:** Trying to generate all 5 phases at once.

**Solution:**

✅ **Always use phase-by-phase generation**

```
Phase 1 → Review → "Go"
Phase 2 → Review → "Go"
...
```

⚠️ **Never:** "Generate entire project in one go"

---

#### ❌ "pgvector extension not found"

**Problem:** Using vanilla PostgreSQL image instead of pgvector.

**Solution:**

In `docker-compose.yml`, ensure:

```yaml
db:
  image: pgvector/pgvector:pg15  # ✅ Correct
  # NOT: postgres:15  # ❌ Wrong
```

---

#### ❌ "Port 3000 already in use"

**Problem:** Another service is using port 3000.

**Solution:**

Change `[APP_PORT]` in your template:

```markdown
[APP_PORT] → 4000  # or any free port
```

Or kill the process:

```bash
# Find process using port 3000
lsof -i :3000

# Kill it
kill -9 <PID>
```

---

#### ❌ "LLM connection refused"

**Problem:** Ollama/local LLM not running.

**Solution:**

```bash
# Start Ollama
ollama serve

# Pull a model
ollama pull llama2

# Verify connection
curl http://localhost:11434/api/tags
```

---

#### ❌ "Build fails with TypeScript errors"

**Problem:** Incomplete generation or version mismatch.

**Solution:**

```bash
# Clear cache
rm -rf node_modules dist .turbo

# Reinstall
npm ci

# Rebuild
npm run build
```

If still failing:

1. Check TypeScript version in `package.json`
2. Verify all imports are correct
3. Run `npm run type-check` for detailed errors

---

### Getting Help

**💬 Community:**

- [GitHub Discussions](https://github.com/Krigsexe/Data-Architect-Template/discussions)
- [Discord Server](#) (coming soon)

**🐞 Bug Reports:**

- [GitHub Issues](https://github.com/Krigsexe/Data-Architect-Template/issues)

**📧 Direct Contact:**

- Email: contact@proxitek.fr

---

**You're all set!** 🎉

Now go build something amazing with this template! 🚀

---

**Next:** [Architecture Overview](architecture.md) →