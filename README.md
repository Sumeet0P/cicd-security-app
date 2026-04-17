# 🚀 CI/CD Security Pipeline with DevSecOps Practices

## 📌 Overview

This project demonstrates a **secure CI/CD pipeline** integrating multiple DevSecOps tools to ensure code, dependencies, and containers are free from vulnerabilities before deployment.

The pipeline enforces **security gates**, meaning the build fails automatically if any critical issue is detected.

---

## 🧠 Architecture

```
Developer →
GitHub Repository →
GitHub Actions Pipeline →
[ Install Dependencies ]
        ↓
[ Snyk (Code & Dependency Scan) ]
        ↓
[ Gitleaks (Secret Detection) ]
        ↓
[ Docker Build ]
        ↓
[ Trivy (Container Scan) ]
        ↓
✅ Secure Build / ❌ Blocked Build
```

---

## 🛠️ Tech Stack

* **CI/CD:** GitHub Actions
* **Containerization:** Docker
* **SAST (Code & Dependency Security):** Snyk
* **Secret Scanning:** Gitleaks
* **Container Security:** Trivy
* **Backend:** Node.js (Express)

---

## 🔥 Key Features

* ✅ Automated CI pipeline on every push
* 🔐 Secret detection using Gitleaks
* 🛡️ Dependency vulnerability scanning using Snyk
* 🐳 Container vulnerability scanning using Trivy
* ❌ Pipeline fails on security issues
* ⚡ Lightweight Docker image using optimized base images
* 📦 Production-only dependency installation

---

## ⚙️ Pipeline Workflow

### 1. Code Push

* Developer pushes code to GitHub

### 2. Install Dependencies

* Installs required Node.js packages for scanning

### 3. Snyk Scan

* Scans dependencies for vulnerabilities
* Fails build if issues detected

### 4. Gitleaks Scan

* Detects hardcoded secrets (API keys, tokens)
* Blocks pipeline if secrets are found

### 5. Docker Build

* Builds container image for the application

### 6. Trivy Scan

* Scans Docker image for vulnerabilities
* Blocks pipeline on critical issues

---

## 🧪 Failure Scenarios (Tested)

### ❌ Secret Leak

* Added fake API key in code
* Gitleaks detected and blocked pipeline

### ❌ Vulnerable Dependency

* Installed vulnerable package (`lodash@4.17.20`)
* Snyk detected vulnerability and failed build

### ❌ Container Vulnerabilities

* Trivy detected base image vulnerabilities
* Pipeline blocked until resolved

---

## 🛠️ How to Run Locally

### 1. Clone repository

```bash
git clone <repo-url>
cd cicd-security-app
```

### 2. Run application

```bash
cd app
npm install
node server.js
```

### 3. Run using Docker

```bash
docker build -t cicd-security-app .
docker run -p 3000:3000 cicd-security-app
```

Open: http://localhost:3000

---

## 📘 Runbook

A detailed operational guide is available in:

```
RUNBOOK.md
```

Includes:

* Setup steps
* Commands used
* Troubleshooting guide
* Security fixes

---

## ⚠️ Security Best Practices Implemented

* No hardcoded secrets
* Environment variables for sensitive data
* Dependency vulnerability management
* Container image hardening
* CI-based security enforcement

---

## 📸 Screenshots (Add these)

* ✅ Successful pipeline run
* ❌ Failed pipeline (Snyk / Gitleaks / Trivy)

---

## 🚀 Future Improvements

* Add deployment step (AWS / Render)
* Integrate Slack/Discord alerts
* Add monitoring (Prometheus + Grafana)
* Add policy-based security gates

---

## 💡 Key Learnings

* Implemented **layered security in CI/CD**
* Learned handling **transitive dependency vulnerabilities**
* Debugged real-world pipeline failures
* Understood **DevSecOps workflow in practice**

---

## 👨‍💻 Author

Built as part of hands-on DevOps learning to simulate real-world CI/CD security practices.

---

⭐ If you found this project useful, consider giving it a star!
