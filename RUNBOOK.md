# 🚀 CI/CD Security Project - Runbook

## 1. Project Setup

### Create project structure

```bash
mkdir cicd-security-app
cd cicd-security-app
mkdir app
```

---

## 2. Initialize Node.js App

### Create package.json

```bash
cd app
npm init -y
npm install express
```

### Create server file

```bash
touch server.js
```

---

## 3. Run Application Locally

```bash
node server.js
```

Expected:

- App runs on port 3000

---

## 4. Docker Setup

### Build Docker image

```bash
docker build -t cicd-security-app .
```

### Run container

```bash
docker run -p 3000:3000 cicd-security-app
```

Expected:

- App accessible at http://localhost:3000

---

## 5. Git Setup

```bash
git init
git add .
git commit -m "initial commit"
git branch -M main
git remote add origin <repo-url>
git push -u origin main
```

---

## 6. CI Pipeline (GitHub Actions)

### File: .github/workflows/ci.yml

Pipeline triggers:

- On push to main branch

Steps:

1. Checkout code
2. Build Docker image

---

## 7. Troubleshooting

### Issue: Workflow push rejected

**Error:**
refusing to allow an OAuth App to create or update workflow

**Fix:**

- Generate GitHub token with:
  - repo
  - workflow permissions

- Use GitHub CLI:
  - gh auth login
  - Select: GitHub.com,
  - HTTPS,
  - Login with a web browser.
  - Verify With one-time code Provided

---

### Issue: Docker build fails

**Check:**

- Correct file paths
- package.json copied before install

---

### Issue: App not accessible

**Check:**

- Port mapping (3000:3000)
- App listening on correct port

---

### Container not accessible in CI

**Error:**

curl: (56) Recv failure

- Possible causes:
  - App not listening on 0.0.0.0
  - Container not ready
  - App crashed

**Fix:**

#### Check containers

docker ps -a

#### Check logs

docker logs <container_id>

#### Wait before curl

sleep 5

Trivy Scan

Purpose:
Scan Docker images for vulnerabilities

Command (CI):

trivy image cicd-security-app

Pipeline Behavior:

Fails if HIGH or CRITICAL vulnerabilities found

📘 Update RUNBOOK (add this)
Vulnerability Detected in Trivy

Example:

HIGH: picomatch vulnerability

Fix:

npm update
npm audit fix

Verify:

npm audit

📘 Update RUNBOOK

Add:

Vulnerability persists after npm fix

Cause:

Issue may be from base image or cached layer

Fix:

docker build --no-cache -t cicd-security-app .

Alternative:

Change base image version

Handling Excessive Vulnerabilities

Problem:
Too many vulnerabilities from base image / dependencies

Strategy:

Install only production dependencies
npm install --only=production
Use stable base image
FROM node:18-slim
Adjust scan severity
severity: CRITICAL

GitHub Actions Deprecation Warning

Issue:
Actions using deprecated Node.js version

Fix:

uses: actions/checkout@v4

Optional:

env:
FORCE_JAVASCRIPT_ACTIONS_TO_NODE24: true
