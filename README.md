# 🚀 CI/CD Security Pipeline with DevSecOps Practices

---

## 📌 Overview

This project demonstrates a **secure CI/CD pipeline with automated deployment** using DevSecOps practices.

The pipeline integrates multiple security tools to ensure that:

* Code is free from vulnerabilities
* Secrets are not exposed
* Container images are secure

🚨 The pipeline enforces **security gates**, meaning it automatically **fails the build** if critical issues are detected.

---

## 🌍 Live Application

http://<your-ec2-ip>:3000

---

## 🧠 Architecture

```
Developer →
GitHub Repository →
GitHub Actions Pipeline →
   ↓
[ Install Dependencies ]
   ↓
[ Snyk (Dependency Scan) ]
   ↓
[ Gitleaks (Secret Detection) ]
   ↓
[ Docker Build ]
   ↓
[ Trivy (Container Scan) ]
   ↓
✅ Secure Build / ❌ Blocked Build
   ↓
SSH Deployment →
AWS EC2 →
Live Application 🌍
```

---

## 🛠️ Tech Stack

* **CI/CD:** GitHub Actions
* **Containerization:** Docker
* **Cloud:** AWS EC2
* **SAST (Dependencies):** Snyk
* **Secret Detection:** Gitleaks
* **Container Security:** Trivy
* **Backend:** Node.js (Express)

---

## 🔥 Key Features

* ✅ Automated CI pipeline on every push
* 🔐 Secret detection using Gitleaks
* 🛡️ Dependency vulnerability scanning using Snyk
* 🐳 Container vulnerability scanning using Trivy
* ❌ Pipeline fails on security issues
* 🚀 Automated deployment to AWS EC2
* 📦 Optimized Docker image using production dependencies

---

## ⚙️ Pipeline Workflow

1. Code pushed to GitHub
2. Dependencies installed (`npm install`)
3. Snyk scans dependencies for vulnerabilities
4. Gitleaks scans repository for secrets
5. Docker image is built
6. Trivy scans container image
7. Application deployed to EC2 via SSH

---

## 🔐 Security Gate Behavior

The pipeline is configured to **fail automatically** if:

* High/Critical vulnerabilities are detected (Snyk / Trivy)
* Secrets are detected in the repository (Gitleaks)

---

## 🚀 Deployment

Deployment is automated using GitHub Actions:

```bash
ssh into EC2
git pull latest code
docker build -t cicd-security-app .
docker run -d -p 3000:3000 --name app cicd-security-app
```

---

## ⚠️ EC2 Configuration

Make sure:

* Port **3000** is open in Security Group
* Port **22 (SSH)** is allowed
* Correct user is used (`ubuntu`)

---

## 🧪 Failure Scenarios (Tested)

### ❌ Secret Leak

* Added fake API key in code
* Gitleaks detected and blocked pipeline

---

### ❌ Vulnerable Dependency

* Installed vulnerable package (`lodash@4.17.20`)
* Snyk detected multiple issues and failed build

---

### ⚠️ Container Vulnerabilities

* Trivy detected vulnerabilities in base image
* Resolved using:

  * Updated dependencies
  * Rebuilt image without cache

---

## 🛠️ Local Setup

### Clone Repository

```bash
git clone <repo-url>
cd cicd-security-app
```

### Run Locally

```bash
cd app
npm install
node server.js
```

---

### Run with Docker

```bash
docker build -t cicd-security-app .
docker run -p 3000:3000 cicd-security-app
```

Open:

```
http://localhost:3000
```

---

## 📘 Documentation

Detailed step-by-step guide:

```
RUNBOOK.md
```

Includes:

* Setup steps
* Commands used
* Troubleshooting
* Security fixes

---

## 📸 Screenshots
* ✅ Successful pipeline run![alt text](/screenshot/image.png)
* ❌ Snyk failure![alt text](/screenshot/image-1.png)
* ❌ Gitleaks detection![alt text](/screenshot/image-2.png)
* ⚠️ Trivy scan results![alt text](/screenshot/image-3.png)
* 🚀 Deployment logs![alt text](/screenshot/image-4.png)

---

## 💡 Key Learnings

* Implemented **end-to-end DevSecOps pipeline**
* Learned handling **real-world vulnerabilities**
* Debugged CI/CD failures and environment issues
* Understood **security-first deployment workflows**

---

## 🚀 Future Improvements

* Add monitoring (Prometheus + Grafana)
* Add alerts (Slack / Discord)
* Use Kubernetes for deployment
* Add Infrastructure as Code (Terraform)

---

## 👨‍💻 Author

Built as a hands-on project to demonstrate real-world DevSecOps practices.

---

⭐ If this helped or inspired you, consider giving it a star!
