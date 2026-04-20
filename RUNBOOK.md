# 🚀 CI/CD Security Project - Runbook

---

# 📌 1. Project Setup

## Create Project Structure

```bash
mkdir cicd-security-app
cd cicd-security-app
mkdir app
```

---

# 📦 2. Initialize Node.js Application

```bash
cd app
npm init -y
npm install express
touch server.js
```

---

# ▶️ 3. Run Application Locally

```bash
node server.js
```

**Expected:**

- App runs on port `3000`

---

# 🐳 4. Docker Setup

## Build Image

```bash
docker build -t cicd-security-app .
```

## Run Container

```bash
docker run -p 3000:3000 cicd-security-app
```

**Expected:**

- App accessible at http://localhost:3000

---

# 🔧 5. Git Setup

```bash
git init
git add .
git commit -m "initial commit"
git branch -M main
git remote add origin <repo-url>
git push -u origin main
```

---

# ⚙️ 6. CI/CD Pipeline Overview

## File Location

```
.github/workflows/ci.yml
```

## Trigger

- On push to `main` branch

## Pipeline Flow

1. Checkout Code
2. Install Dependencies
3. Snyk Scan (Code + Dependencies)
4. Gitleaks Scan (Secrets)
5. Docker Build
6. Trivy Scan (Container Security)

---

# 🔐 7. Security Tools

## Snyk (SAST)

- Scans dependencies for vulnerabilities

## Gitleaks

- Detects hardcoded secrets

## Trivy

- Scans Docker images for vulnerabilities

---

# 🛠️ 8. Common Issues & Fixes

---

## ❌ Issue: Workflow Push Rejected

**Error:**

```
refusing to allow an OAuth App to create or update workflow
```

**Fix:**

- Generate GitHub token with:
  - `repo`
  - `workflow` permissions

OR

```bash
gh auth login
```

---

## ❌ Issue: App Not Accessible

**Check:**

- Port mapping (`3000:3000`)
- App running on `0.0.0.0`

---

## ❌ Issue: Container Not Accessible in CI

**Error:**

```
curl: (56) Recv failure
```

**Fix:**

```bash
docker ps -a
docker logs <container_id>
sleep 5
```

---

## ❌ Issue: Docker Build Fails

**Check:**

- Correct file paths
- `package.json` copied before install

---

# 🔍 9. Trivy (Container Security)

## Purpose

Scan Docker image for vulnerabilities

## Command

```bash
trivy image cicd-security-app
```

## Behavior

- Fails pipeline on CRITICAL vulnerabilities

---

## ❌ Vulnerability Detected

**Fix:**

```bash
npm update
npm audit fix
```

---

## ❌ Vulnerability Still Exists

**Cause:**

- Base image or Docker cache

**Fix:**

```bash
docker build --no-cache -t cicd-security-app .
```

**Alternative:**

- Change base image (e.g., node:18-slim)

---

## ⚠️ Too Many Vulnerabilities

**Solution:**

```bash
npm install --only=production
```

Use stable base image:

```dockerfile
FROM node:18-slim
```

Adjust scan severity:

```yaml
severity: CRITICAL
```

---

# 🔐 10. Secret Detection (Gitleaks)

## Purpose

Detect exposed secrets in code

## Pipeline Step

```yaml
uses: gitleaks/gitleaks-action@v2
```

---

## ❌ Secret Found

**Fix Steps:**

1. Move secret to environment variable
2. Create `.env` file
3. Add `.env` to `.gitignore`
4. Remove secret from code

---

# 🧠 11. Snyk (Code & Dependency Security)

## Purpose

Scan dependencies for vulnerabilities

## Pipeline Step

```yaml
uses: snyk/actions/node@master
```

---

## ❌ Error: No Supported Files Found

**Cause:**

- `package.json` not in root

**Fix:**

```yaml
working-directory: ./app
```

---

## ❌ Error: Missing node_modules

**Cause:**

- Dependencies not installed

**Fix:**

```yaml
- name: Install dependencies
  working-directory: ./app
  run: npm install
```

---

## ❌ Vulnerabilities Found

**Fix:**

```bash
npm update
npm audit fix
```

---

# ⚠️ 12. GitHub Actions Warnings

## Node.js Deprecation Warning

**Issue:**

- Actions using Node.js 20

**Fix:**

```yaml
uses: actions/checkout@v4
```

**Optional:**

```yaml
env:
  FORCE_JAVASCRIPT_ACTIONS_TO_NODE24: true
```

---

# 📘 13. Key Learnings

- CI pipelines require correct execution order
- Security must be layered (code + secrets + container)
- Most failures come from environment/context issues
- Not all vulnerabilities need immediate fixing (prioritize CRITICAL)

---

# 🚀 14. Final Pipeline Summary

```text
Code →
Install Dependencies →
Snyk →
Gitleaks →
Docker Build →
Trivy →
✅ Secure Build
```

---


Deploy to EC2

Purpose:
Deploy application after successful pipeline

Steps:

ssh into EC2
git pull latest code
docker build
docker run