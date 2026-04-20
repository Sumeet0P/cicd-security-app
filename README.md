# 🚀 CI/CD Security Pipeline with DevSecOps Practices

---

## 📌 Overview

This project demonstrates a **secure CI/CD pipeline with automated deployment** integrating DevSecOps tools to ensure application security at every stage.

The pipeline enforces **security gates**, blocking builds if critical vulnerabilities or secrets are detected.

---

## 🌍 Live Application

http://<your-ec2-ip>:3000

---

## 🧠 Architecture

```
Developer →
GitHub →
GitHub Actions →
[ Snyk ]
[ Gitleaks ]
[ Docker Build ]
[ Trivy ]
        ↓
SSH →
AWS EC2 →
Live Application 🌍
```

---

## 🛠️ Tech Stack

- GitHub Actions (CI/CD)
- Docker
- AWS EC2
- Snyk (SAST)
- Gitleaks (Secrets)
- Trivy (Container Security)
- Node.js (Express)

---

## 🔥 Features

- ✅ Automated CI/CD pipeline
- 🔐 Secret detection (Gitleaks)
- 🛡️ Dependency scanning (Snyk)
- 🐳 Container security (Trivy)
- 🚀 Automated deployment to EC2
- ❌ Build fails on security issues

---

## ⚙️ Pipeline Workflow

1. Code pushed to GitHub
2. Dependencies installed
3. Snyk scans for vulnerabilities
4. Gitleaks scans for secrets
5. Docker image is built
6. Trivy scans container
7. Application deployed to EC2

---

## 🚀 Deployment

Deployment is automated via GitHub Actions:

- SSH into EC2
- Pull latest code
- Build Docker image
- Restart container

---

## 🧪 Failure Scenarios Tested

- Secret leakage → blocked by Gitleaks
- Vulnerable dependency → blocked by Snyk
- Container vulnerabilities → blocked by Trivy

---

## 🛠️ Local Setup

```bash
git clone <repo-url>
cd cicd-security-app
cd app
npm install
node server.js
```

Docker:

```bash
docker build -t cicd-security-app .
docker run -p 3000:3000 cicd-security-app
```

---

## 📘 Documentation

Refer:

```
RUNBOOK.md
```

---

## ⚠️ Security Practices

- No hardcoded secrets
- Environment variable usage
- Dependency vulnerability management
- Container hardening
- CI-based security enforcement

---

## 📸 Screenshots

- Successful pipeline
- Failed security scans
- Live application

---

## 💡 Key Learnings

- Built end-to-end DevSecOps pipeline
- Implemented layered security
- Debugged real-world CI/CD issues
- Automated deployment to cloud

---

## 👨‍💻 Author

Built to demonstrate real-world DevSecOps practices.

---

⭐ Star this repo if you like it!
