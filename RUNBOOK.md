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

- On push to `main`

## Pipeline Flow

```
Code →
Install Dependencies →
Snyk →
Gitleaks →
Docker Build →
Trivy →
Deploy (EC2)
```

---

# 🔐 7. Security Tools

| Tool     | Purpose                           |
| -------- | --------------------------------- |
| Snyk     | Dependency vulnerability scanning |
| Gitleaks | Secret detection                  |
| Trivy    | Container vulnerability scanning  |

---

# 🚀 8. Deployment (EC2)

## Purpose

Deploy application automatically after successful pipeline

## Steps Executed in CI

```bash
ssh into EC2
cd cicd-security-app || git clone repo
git pull origin main
docker stop app || true
docker rm app || true
docker build -t cicd-security-app .
docker run -d -p 3000:3000 --name app cicd-security-app
```

---

# 🛠️ 9. Common Issues & Fixes

---

## ❌ Workflow Push Rejected

**Error:**

```
refusing to allow an OAuth App to create or update workflow
```

**Fix:**

- Generate GitHub token with `repo` + `workflow`
  OR

```bash
gh auth login
```

---

## ❌ SSH Authentication Failed

**Error:**

```
ssh: unable to authenticate
```

**Fix:**

- Ensure EC2_KEY contains full `.pem` private key
- No extra characters (like `%`)
- Correct username: `ubuntu`

---

## ❌ App Not Accessible

**Check:**

- Port 3000 open in security group
- App listening on `0.0.0.0`

---

## ❌ Container Not Accessible in CI

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

## ❌ Docker Build Fails

**Check:**

- Correct file paths
- `package.json` copied before install

---

# 🔍 10. Trivy (Container Security)

## Command

```bash
trivy image cicd-security-app
```

## Fix Vulnerabilities

```bash
npm update
npm audit fix
```

---

## ❌ Persistent Vulnerabilities

**Fix:**

```bash
docker build --no-cache -t cicd-security-app .
```

Use better base image:

```dockerfile
FROM node:18-slim
```

---

# 🔐 11. Gitleaks (Secrets)

## Detect Secrets

```yaml
uses: gitleaks/gitleaks-action@v2
```

## Fix

- Move secrets to env variables
- Add `.env` to `.gitignore`

---

# 🧠 12. Snyk (Dependencies)

## Fix Path Issue

```yaml
working-directory: ./app
```

## Install Dependencies

```yaml
run: npm install
```

---

# ⚠️ 13. GitHub Actions Warning

```yaml
uses: actions/checkout@v4
```

Optional:

```yaml
env:
  FORCE_JAVASCRIPT_ACTIONS_TO_NODE24: true
```

---

# 📘 14. Key Learnings

- CI pipelines require correct step ordering
- Security must be layered
- Most failures are environment-related
- Not all vulnerabilities need fixing immediately

---

# 🚀 15. Final Pipeline

```
Code →
Snyk →
Gitleaks →
Docker →
Trivy →
Deploy →
Live App
```
