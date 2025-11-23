# ❓ Frequently Asked Questions

---

## General Questions

### What is the Data Architect Template?

A **production-ready master template** for generating complete AI/Data SaaS applications with:

✅ AI agent orchestration
✅ Human-in-the-loop validation
✅ Vector search (pgvector)
✅ Secure code execution
✅ Plugin system
✅ Full monitoring
✅ CI/CD pipelines
✅ 42+ deliverables

**Think of it as:** A blueprint that Claude Code (or any LLM) uses to generate **your entire project** in 5 phases.

---

### Who is this for?

🎯 **Target Users:**

- **Solo developers** building AI tools
- **Startups** needing MVP fast
- **Teams** standardizing architecture
- **Enterprises** requiring production-grade foundations

✅ **Skill Level:** Intermediate+ developers familiar with:
- Modern JavaScript/TypeScript
- Docker basics
- REST APIs
- Database concepts

---

### How is this different from boilerplates?

| Feature | Traditional Boilerplate | This Template |
|---------|-------------------------|---------------|
| **Customization** | Edit existing code | Fill placeholders |
| **Scope** | Basic structure | Complete project |
| **AI Integration** | Manual | Built-in (LLM + embeddings) |
| **Security** | Basic auth | Sandbox execution + RBAC |
| **Scalability** | Single-tenant only | Single/Multi-tenant ready |
| **Monitoring** | None or basic | Prometheus + Grafana |
| **Deployment** | Manual | Docker + Umbrel + scripts |

---

## Technical Questions

### Why pgvector? Can I use Pinecone/Weaviate instead?

**pgvector is included by default** because:

✅ **No separate service** (embedded in PostgreSQL)
✅ **ACID transactions** (vectors + metadata together)
✅ **Zero cost** (self-hosted)
✅ **Simpler ops** (one database to manage)

**Can you swap it?** Yes!

Replace in template:

```markdown
[SEARCH_ENGINE] → Pinecone
```

Then customize in Phase 3:

```typescript
import { PineconeClient } from '@pinecone-database/pinecone';

// Instead of pgvector queries
const pinecone = new PineconeClient();
await pinecone.init({ apiKey: process.env.PINECONE_KEY });
```

**Trade-off:** External dependency + costs.

---

### Can I use Python instead of Node.js?

**Yes!** Change these placeholders:

```markdown
[BACKEND_RUNTIME] → Python 3.11+
[BACKEND_FRAMEWORK] → FastAPI
[ORM_CHOICE] → SQLAlchemy
[PACKAGE_MANAGER] → poetry
```

Claude Code will generate Python code instead.

**Supported runtimes:**

- Node.js / Bun / Deno (JavaScript/TypeScript)
- Python
- Go
- Rust (experimental)

---

### Why Fastify? Can I use Express?

**Fastify is default** for:

✅ Performance (2-3x faster)
✅ TypeScript support
✅ Schema validation built-in

**Want Express?**

```markdown
[BACKEND_FRAMEWORK] → Express.js
```

Generated code will use Express patterns.

---

### What if I don't want AI agents?

**The template is modular**. Disable features by:

1. Setting `[NUM_AGENTS] → 0`
2. Removing agent-related sections in Phase 4

You'll still get:

✅ Full-stack boilerplate
✅ Database with pgvector
✅ Auth + RBAC
✅ Monitoring
✅ CI/CD

---

## Usage Questions

### Do I need Claude Code specifically?

**No!** Any LLM code generation tool works:

✅ **Claude Code** (Anthropic) - Recommended
✅ **GitHub Copilot Workspace**
✅ **ChatGPT Code Interpreter**
✅ **Google Gemini**
✅ **Cursor AI**
✅ **Windsurf**
✅ **Local LLMs** (with code gen capability)

The template is **LLM-agnostic** - just a structured Markdown prompt.

---

### How long does generation take?

**Phase-by-phase approach:**

- **Phase 1** (Structure + Config): ~5 minutes
- **Phase 2** (Backend Core): ~10 minutes
- **Phase 3** (Frontend Core): ~15 minutes
- **Phase 4** (AI Engine): ~15 minutes
- **Phase 5** (Connectors + Polish): ~20 minutes

**Total:** ~60-75 minutes for complete project.

⚠️ **Warning:** Generating all 5 phases at once hits context limits and produces incomplete code.

---

### Can I generate once and extend later?

**Absolutely!** That's the design.

**Workflow:**

1. Generate base project (Phases 1-5)
2. Customize/extend manually
3. Add custom agents in `src/agents/`
4. Add connectors in `src/connectors/`
5. Build plugins in `plugins/`

The generated code is **clean, typed, and documented** - easy to extend.

---

## Deployment Questions

### Can I deploy to Vercel/Netlify?

**Frontend:** Yes (static build)

**Backend:** Partial

✅ **Vercel Edge Functions** - Light workloads only
❌ **Long-running workers** - Need dedicated server

**Recommended for full-stack:**

- **VPS** (Hetzner, DigitalOcean, Linode)
- **Kubernetes** (GKE, EKS, AKS)
- **Docker** (any host)
- **Umbrel** (local/self-hosted)

---

### What's the Umbrel deployment?

**Umbrel** is a personal server OS (like Home Assistant).

**Benefits:**

✅ **One-click install** (via App Store)
✅ **Self-hosted** (your hardware)
✅ **Privacy-first** (no cloud)
✅ **Low-power** (Raspberry Pi compatible)

Generated projects include `umbrel-app.yml` for easy submission to Umbrel App Store.

---

### Is Docker required?

**No, but highly recommended.**

**Options:**

1. **Docker Compose** (✅ Easiest)
2. **Native Installation** (manual setup)
3. **Kubernetes** (production scale)

**Without Docker:**

```bash
# Use native install scripts
./scripts/install.sh  # Linux
.\scripts\install.ps1  # Windows
```

You'll need to install PostgreSQL, Redis, Node.js manually.

---

## Security Questions

### Is the sandbox really secure?

**Multi-layer security:**

**Layer 1: WASM**
✅ No file system access
✅ No network access
✅ Memory isolated
✅ Can't escape to host OS

**Layer 2: Firecracker (Linux)**
✅ Full microVM isolation
✅ Kernel-level security
✅ KVM hardware virtualization

**Layer 3: Docker (Fallback)**
⚠️ Least secure (but still isolated)
✅ Read-only filesystem
✅ No network
✅ Memory + CPU limits

**Plus:**

✅ Static code analysis before execution
✅ Risk scoring (blocks high-risk operations)
✅ Human validation for uncertain code

**Bottom line:** Safer than running arbitrary code directly.

---

### What about GDPR compliance?

**Built-in features:**

✅ **Anonymization** (SHA-256 hashing)
✅ **Data export** (JSON format)
✅ **Right to deletion** (CASCADE deletes)
✅ **Consent management** (opt-in cookies)
✅ **Audit trail** (who accessed what)

**Compliance docs** generated in Phase 5:

- `PRIVACY_POLICY.md` (editable template)
- `TERMS_OF_SERVICE.md` (editable template)
- `DATA_PROCESSING_AGREEMENT.md` (Enterprise)

**Note:** You're still responsible for reviewing and customizing these for your jurisdiction.

---

## Cost Questions

### Is this free?

**The template itself:** ✅ 100% free (MIT license)

**Costs you may incur:**

💵 **LLM API usage** (if using OpenAI/Anthropic)
💵 **Server hosting** (VPS, cloud, etc.)
💵 **Optional services** (Pinecone, Auth0, etc.)

**Free options:**

✅ **Local LLMs** (Ollama, llama.cpp - no API costs)
✅ **Self-hosting** (your hardware - no VPS costs)
✅ **Open source everything** (PostgreSQL, Redis, etc.)

---

### What's the total cost to run?

**Self-Hosted (Cheapest):**

- **Hardware:** $0 (existing PC/Raspberry Pi)
- **Electricity:** ~$5-10/month
- **Internet:** $0 (existing)

**Total:** ~$5-10/month

**VPS Hosted:**

- **Server:** $5-20/month (4GB RAM)
- **Domain:** $10/year
- **SSL:** Free (Let's Encrypt)

**Total:** ~$5-20/month

**Cloud Hosted (Enterprise):**

- **Compute:** $50-500/month (auto-scaling)
- **Database:** $20-100/month (managed PostgreSQL)
- **Storage:** $5-50/month

**Total:** $75-650/month (depends on usage)

---

## Troubleshooting

### Generation failed with "context too large"

**Problem:** Tried to generate all 5 phases at once.

**Solution:**

✅ **Always use phase-by-phase** generation:

```
Phase 1 only → Review → "Go"
Phase 2 only → Review → "Go"
...
```

❌ **Never:** "Generate entire project"

---

### "Module not found" errors after generation

**Problem:** Missing dependencies in `package.json`.

**Solution:**

```bash
# Reinstall dependencies
rm -rf node_modules package-lock.json
npm install

# Or use pnpm for faster install
pnpm install
```

---

### pgvector queries returning no results

**Problem:** Embeddings not created or wrong dimensions.

**Debug:**

```sql
-- Check embeddings exist
SELECT COUNT(*) FROM embeddings;

-- Check dimensions match model
SELECT 
  provider,
  model,
  vector_dims(embedding) as dimensions
FROM embeddings
LIMIT 1;

-- If dimensions mismatch, recreate table
DROP TABLE embeddings;
-- Re-run migrations
```

---

### Workers not processing jobs

**Problem:** Redis connection or BullMQ config issue.

**Debug:**

```bash
# Check Redis running
redis-cli ping
# Should return: PONG

# Check BullMQ dashboard
npm run bull-board
# Access: http://localhost:3000/admin/queues

# Check worker logs
docker-compose logs worker
```

---

## Contributing Questions

### Can I contribute new templates?

**Yes!** We welcome:

✅ **New placeholders** (for additional customization)
✅ **Example projects** (showcase what you built)
✅ **Agent templates** (reusable AI agents)
✅ **Connector templates** (new integrations)
✅ **Translations** (i18n for more languages)

**See:** [CONTRIBUTING.md](../CONTRIBUTING.md) for guidelines.

---

### How do I report bugs?

1. **Check** [existing issues](https://github.com/Krigsexe/Data-Architect-Template/issues)
2. **Open new issue** with:
   - Template version used
   - LLM tool (Claude Code, GPT-4, etc.)
   - Placeholder values (if relevant)
   - Error messages
   - Steps to reproduce

---

### Can I use this commercially?

**Yes!** MIT License means:

✅ Use in commercial projects
✅ Modify as needed
✅ Sell generated applications
✅ No attribution required (but appreciated)

**Only requirement:** Include MIT license text in your code.

---

## Advanced Questions

### Can I nest templates?

**Yes!** For example:

**Master Template** generates project structure
↓
**Agent Template** generates custom agent
↓
**Connector Template** generates API integration

Each level fills its own placeholders.

---

### How do I add a new placeholder?

1. **Define in `templates/master-template.md`:**

```markdown
[MY_CUSTOM_SETTING] → default_value
```

2. **Document in `templates/placeholders-reference.md`:**

```markdown
| `[MY_CUSTOM_SETTING]` | Description | Examples | Required |
```

3. **Update `scripts/validate-placeholders.sh`** (if essential):

```bash
ESSENTIAL_PLACEHOLDERS+=(
    "MY_CUSTOM_SETTING"
)
```

4. **Submit PR** with your addition

---

### Can I use this for non-AI projects?

**Absolutely!**

Just set:

```markdown
[NUM_AGENTS] → 0
[NUM_CONNECTORS] → 0
```

You'll get a **production-ready full-stack boilerplate** with:

✅ TypeScript + React
✅ PostgreSQL + Redis
✅ Auth + RBAC
✅ Docker deployment
✅ CI/CD pipelines
✅ Monitoring

No AI components required.

---

## Still Have Questions?

**💬 Community:**

- [GitHub Discussions](https://github.com/Krigsexe/Data-Architect-Template/discussions)
- Discord (coming soon)

**📧 Email:**

- contact@proxitek.fr

**🐞 Bug Reports:**

- [GitHub Issues](https://github.com/Krigsexe/Data-Architect-Template/issues)

---

**Happy coding!** 🚀