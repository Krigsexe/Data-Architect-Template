# 🏥 Example: Healthcare Document Triage

## Description

An AI-powered system for automatically triaging and routing medical documents (patient records, lab results, prescriptions) to appropriate departments with HIPAA compliance.

---

## Tech Stack

**Backend:**
- Runtime: Node.js 20 LTS
- Framework: Fastify
- ORM: Prisma
- Queue: BullMQ

**Frontend:**
- Framework: React 18
- Build: Vite
- UI: Radix UI + TailwindCSS
- State: Zustand

**Database:**
- PostgreSQL 15 + pgvector
- Redis 7

**AI/ML:**
- Local: Ollama (Mistral Medical)
- OCR: Tesseract + Google Vision API
- Embeddings: all-MiniLM-L6-v2 (384d)

**Deployment:**
- Docker Compose
- HIPAA-compliant VPS

---

## Features

### Core Functionality

✅ **Document Upload** (PDF, Images, Scans)
✅ **OCR Extraction** (structured text from images)
✅ **Semantic Classification** (via pgvector similarity)
✅ **Auto-Routing** to:
- Radiology
- Laboratory
- Pharmacy
- General Medicine
- Emergency

✅ **PHI Detection** (redaction of sensitive data)
✅ **Audit Trail** (HIPAA requirement)
✅ **Human Validation** for low-confidence cases
✅ **Encrypted Storage** (AES-256 at rest)

---

## Placeholder Values

```markdown
# Project Identity
[PROJECT_NAME] → MediTriage
[DOMAIN_DESCRIPTION] → healthcare document intelligent routing
[DESCRIPTION_TYPE] → automated triage system
[TAGLINE_SHORT] → AI-powered medical document routing with HIPAA compliance

# Developer
[DEVELOPER_NAME] → Dr. Sarah Johnson
[GITHUB_USER] → drsarahj
[DEVELOPER_TAGLINE] → Healthcare IT Innovation

# Stack
[BACKEND_FRAMEWORK] → Fastify
[FRONTEND_FRAMEWORK] → React 18
[ORM_CHOICE] → Prisma
[BUILD_TOOL] → Vite

# Functional
[NUM_AGENTS] → 6
[LIST_BUSINESS_TASKS] → documents, lab_results, prescriptions, radiology_images, patient_records, emergency_notes
[DEFAULT_CONFIDENCE_THRESHOLD] → 85  # Higher for medical context

# Modules
[MODULE_1_NAME] → OCR Engine
[MODULE_1_DESCRIPTION] → Extract text from medical images and PDFs

[MODULE_2_NAME] → PHI Detector
[MODULE_2_DESCRIPTION] → Identify and redact Protected Health Information

[MODULE_3_NAME] → Department Router
[MODULE_3_DESCRIPTION] → Route to appropriate medical department

# Compliance
[COMPLIANCE_STANDARDS] → HIPAA
[RETENTION_DAYS] → 2555  # 7 years (HIPAA requirement)

# Security
[REQUIRE_2FA_FOR_CRITICAL] → true
[CAPTCHA_PROVIDER] → Cloudflare Turnstile

# Connectors
[NUM_CONNECTORS] → 12
[LIST_CONNECTOR_EXAMPLES] → local_FS, SFTP, Epic_EHR, Cerner_API, HL7_FHIR, Google_Vision, Tesseract, AWS_S3, Azure_Blob, SMTP, Slack_alerts, audit_logger
```

---

## Custom Agents

### 1. OCR Agent

```typescript
export class OCRAgent extends BaseAgent {
  async execute(input: { file: File }): Promise<AgentResult> {
    // Try Tesseract first (free)
    const tessResult = await tesseract.recognize(input.file);
    
    if (tessResult.confidence < 80) {
      // Fallback to Google Vision (better accuracy)
      const visionResult = await googleVision.detectText(input.file);
      return this.processText(visionResult.text, visionResult.confidence);
    }
    
    return this.processText(tessResult.text, tessResult.confidence);
  }
}
```

### 2. PHI Detector Agent

```typescript
export class PHIDetectorAgent extends BaseAgent {
  private patterns = {
    ssn: /\b\d{3}-\d{2}-\d{4}\b/g,
    mrn: /MRN[:\s]*(\d+)/gi,
    dob: /\b(\d{1,2}[\/\-]\d{1,2}[\/\-]\d{2,4})\b/g,
    phone: /\b\d{3}[-.]?\d{3}[-.]?\d{4}\b/g,
  };
  
  async execute(input: { text: string }): Promise<AgentResult> {
    const detections: PHIDetection[] = [];
    
    for (const [type, pattern] of Object.entries(this.patterns)) {
      const matches = input.text.matchAll(pattern);
      for (const match of matches) {
        detections.push({
          type,
          value: match[0],
          start: match.index,
          end: match.index + match[0].length
        });
      }
    }
    
    return {
      detections,
      redacted: this.redact(input.text, detections),
      confidence: 100 // Regex-based, high confidence
    };
  }
}
```

### 3. Department Router Agent

```typescript
export class DepartmentRouterAgent extends BaseAgent {
  async execute(input: { text: string }): Promise<AgentResult> {
    // Use embeddings for semantic routing
    const embedding = await this.createEmbedding(input.text);
    
    // Search similar documents
    const similar = await db.$queryRaw`
      SELECT 
        department,
        1 - (embedding <=> ${embedding}) AS similarity
      FROM department_templates
      ORDER BY embedding <=> ${embedding}
      LIMIT 3
    `;
    
    const topMatch = similar[0];
    
    return {
      department: topMatch.department,
      confidence: topMatch.similarity * 100,
      alternatives: similar.slice(1).map(s => ({
        department: s.department,
        confidence: s.similarity * 100
      }))
    };
  }
}
```

---

## Deployment Notes

### HIPAA Compliance Checklist

- [ ] TLS 1.3 for all connections
- [ ] AES-256 encryption at rest
- [ ] Audit logging enabled (all access)
- [ ] 2FA enforced for all users
- [ ] Automatic session timeout (15 min)
- [ ] Data retention policy (7 years)
- [ ] Backup encryption
- [ ] Network segmentation (VPN)
- [ ] Physical security (datacenter)
- [ ] BAA (Business Associate Agreement) with hosting provider

### Recommended Hosting

**HIPAA-Compliant VPS:**

✅ **AWS** (HIPAA-eligible services)
✅ **Azure** (Azure Health Data Services)
✅ **Google Cloud** (Cloud Healthcare API)
✅ **Atlantic.net** (HIPAA VPS)

**NOT recommended:**

❌ DigitalOcean (no BAA)
❌ Hetzner (not HIPAA-certified)
❌ Self-hosted (unless certified facility)

---

## Screenshots

(Add screenshots of your deployed MediTriage here)

---

## Lessons Learned

### What Worked Well

✅ **pgvector for semantic routing** → 95% accuracy after training
✅ **Tesseract + Google Vision fallback** → OCR reliability
✅ **Human validation queue** → Catches edge cases
✅ **Audit trail** → Easy HIPAA compliance reporting

### Challenges

⚠️ **OCR on handwritten notes** → Still requires manual review
⚠️ **Complex medical terminology** → Needed custom embeddings training
⚠️ **HIPAA storage requirements** → Encryption keys management

### Future Improvements

- Train custom medical LLM on hospital data
- Add voice dictation support
- Mobile app for field use
- Integration with hospital EHR systems

---

## License

MIT (for the template usage)

**Note:** Medical applications require additional certifications (FDA, HIPAA, etc.)

---

**Built by:** Dr. Sarah Johnson | [GitHub](https://github.com/drsarahj/meditriage)

**Powered by:** Data Architect Template