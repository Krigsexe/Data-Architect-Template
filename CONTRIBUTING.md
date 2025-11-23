# 🤝 Contributing to Data Architect Template

Thank you for considering contributing to this project! 🎉

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How to Contribute](#how-to-contribute)
- [Development Setup](#development-setup)
- [Contribution Guidelines](#contribution-guidelines)
- [Style Guide](#style-guide)
- [Review Process](#review-process)

---

## 📜 Code of Conduct

This project adheres to a [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

---

## 🚀 How to Contribute

### Types of Contributions

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

---

## 🛠️ Development Setup

### Prerequisites

- Git
- A text editor (VS Code recommended)
- Basic knowledge of Markdown
- (Optional) Claude Code or similar LLM for testing

### Getting Started

```bash
# 1. Fork the repository on GitHub

# 2. Clone your fork
git clone https://github.com/YOUR_USERNAME/Data-Architect-Template.git
cd Data-Architect-Template

# 3. Create a branch for your contribution
git checkout -b feature/amazing-feature

# 4. Make your changes

# 5. Test your changes
./scripts/validate-placeholders.sh templates/master-template.md

# 6. Commit your changes
git commit -m 'Add: Amazing feature'

# 7. Push to your fork
git push origin feature/amazing-feature

# 8. Open a Pull Request
```

---

## 📐 Contribution Guidelines

### Markdown Structure

- Use `#` for top-level headings (never `##` at the first level)
- Separate major sections with `---`
- Indent lists with 2 spaces
- Use triple backtick code fences ` ``` `
- Keep lines under 120 characters when possible

### Placeholders

**Format:** `[PLACEHOLDER_NAME]` (uppercase, underscores)

**Rules:**

- Always document new placeholders in `templates/placeholders-reference.md`
- Provide example values in comments
- Use consistent naming (if `[BACKEND_FRAMEWORK]` exists, don't create `[BACK_END_FRAMEWORK]`)

**Example:**

```markdown
<!-- ✅ GOOD -->
[PROJECT_NAME] → Ex: Klaro
[BACKEND_FRAMEWORK] → Ex: Fastify

<!-- ❌ BAD -->
[projectName] → inconsistent format
[backend] → too vague
```

### Documentation

- Add concrete examples in `docs/examples/`
- Update `README.md` if adding a major feature
- Document architectural decisions in `docs/architecture.md`
- Include screenshots for UI-related changes

### Testing

**Before submitting a PR:**

1. **Validate placeholders:** `./scripts/validate-placeholders.sh`
2. **Test with Claude Code:** Generate a sample project with your changes
3. **Check links:** Ensure all internal links work
4. **Verify formatting:** Run a Markdown linter

---

## 🎨 Style Guide

### Commit Messages

**Format:** `Type: Short description`

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
✅ Add: Support Bun runtime backend
✅ Fix: Placeholder [APP_PORT] missing in docker-compose
✅ Docs: Add Python FastAPI example
✅ Refactor: Simplify pgvector configuration section

❌ Updated stuff
❌ fixed bug
❌ changes
```

### Pull Request Template

**Title:** Same format as commits

**Description should include:**

- **What:** Brief description of changes
- **Why:** Motivation and context
- **How:** Technical approach (if complex)
- **Testing:** How you tested the changes
- **Breaking Changes:** If applicable
- **Related Issues:** `Closes #123` or `Related to #456`

**Example:**

```markdown
## What
Added support for Bun runtime as backend framework option.

## Why
Bun is gaining popularity for its performance and compatibility with Node.js.

## How
- Added `[BUN_VERSION]` placeholder
- Updated backend framework selection logic
- Added example in docs/examples/

## Testing
- Generated sample project with `[BACKEND_FRAMEWORK] = Bun`
- Verified Docker setup works
- Validated all placeholders

## Breaking Changes
None

Closes #42
```

---

## 🔍 Review Process

### Timeline

1. **Auto-checks:** Link validation, Markdown format (~5 minutes)
2. **Maintainer review:** First review within 48 hours
3. **Testing:** Template generation test with Claude Code
4. **Approval:** If all checks pass, merge to `main`

### What We Look For

✅ **Good:**

- Clear, concise changes
- Well-documented placeholders
- Tested with Claude Code
- Follows style guide
- Adds value to the template

❌ **Issues:**

- Undocumented placeholders
- Broken links or formatting
- Not tested
- Inconsistent with existing structure
- No clear benefit

---

## 🌟 Becoming a Maintainer

If you contribute regularly and with quality, we may offer you the role of maintainer with:

- Write access to the repository
- Participation in architectural decisions
- Mention in the README

Contact [@Krigsexe](https://github.com/Krigsexe) if interested.

---

## ❓ Questions?

- 💬 [GitHub Discussions](https://github.com/Krigsexe/Data-Architect-Template/discussions)
- 📧 Email: contact@proxitek.fr

---

**Thank you for contributing!** 🙏

*"A good template is worth a thousand lines of boilerplate code."*