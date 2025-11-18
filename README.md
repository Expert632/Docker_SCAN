# 🔒 DevSecOps Lab: Docker, Trivy, and Security Gates

This repository demonstrates a **complete DevSecOps workflow**, showcasing how to integrate container security scanning, CI/CD pipelines, and security gates in a practical and educational way. The lab walks through the lifecycle of a Docker image from a clean state to a vulnerable state, and how automated pipelines can detect and enforce security policies.

---

## 🏗 Lab Steps

### 1. Creation of a new repository
A fresh GitHub repository was created with a clear structure, including:
- `Dockerfile` for container images
- `.github/workflows/` for CI/CD pipelines
- `reports/` (optional) for scan outputs

> ✅ Goal: simulate a real-world starting point for a secure DevOps workflow.

---

### 2. Validation
Initial validation was performed to ensure:
- The repository builds correctly
- Docker images can be built without errors
- GitHub Actions workflows are properly triggered

> ✅ Goal: establish a clean baseline before adding security layers.

---

### 3. Creation of Dockerfiles without vulnerabilities
Dockerfiles were created following best practices:
- Using **official, up-to-date base images**
- Minimal package installation
- No intentionally vulnerable packages

> ✅ Goal: demonstrate a secure Docker image baseline.

---

### 4. Creation of Pipeline 01: Practical DOCKER with Trivy
A **first CI pipeline** was implemented to:
- Build the Docker image
- Scan the image using **Trivy** for vulnerabilities
- Generate reports in both JSON and TXT formats

> ✅ Goal: integrate automated container vulnerability scanning into CI/CD.

---

### 5. Scan image with Trivy: No critical vulnerability detected
The pipeline scanned the initial Docker image:
- Result: **No critical vulnerabilities detected**
- Demonstrates a **safe image baseline**

---

### 6. Generation of JSON report
Trivy generated a **machine-readable JSON report** (`scan-report.json`) containing:
- Package information
- Vulnerabilities with severity levels
- Metadata for automated processing

> ✅ Goal: provide structured output for downstream automation and security gates.

---

### 7. Modification of Dockerfiles to inject a critical vulnerability
To simulate real-world risk introduction:
- Dockerfiles were modified to include **older, vulnerable packages**
- Base images were downgraded intentionally

> 🎯 This step allows testing how pipelines detect critical issues introduced during development.

---

### 8. Scan image with Trivy: Critical vulnerability detected
After modification:
- The Trivy scan detected **at least one CRITICAL vulnerability**
- JSON and TXT reports were updated
- Logs clearly showed: `Critical vulnerability detected`

> ✅ Goal: demonstrate how even small changes can introduce high-risk vulnerabilities.

---

### 9. Creation of Pipeline 02: Security Gate
A **dedicated Security Gate pipeline** was created:
- Reads the Trivy JSON report
- Checks for any CRITICAL vulnerabilities
- Fails the pipeline (`exit 1`) if any critical vulnerabilities are found
- Passes the pipeline if none are detected

> ✅ Goal: enforce **strict security checks** before allowing deployments.

---

### 10. Display red Pipeline 03 after detecting the critical vulnerability
Finally:
- The Security Gate pipeline turns **red** when CRITICAL vulnerabilities are detected
- Demonstrates the difference between:
  - Informational scans (pipeline green)
  - Enforced security gates (pipeline red)

> ✅ Goal: showcase **automated prevention of insecure deployments** in CI/CD.

---

## 🛠 Tools & Technologies

- **Docker** – containerization and image hardening
- **Trivy** – open-source container vulnerability scanner
- **GitHub Actions** – CI/CD orchestration
- **JSON/TXT Reports** – structured output for automated processing
- **Security Gate Workflow** – enforce policy based on vulnerability severity

---

## 🚀 What this project demonstrates

By completing this lab, I can show:
- Expertise in building **end-to-end DevSecOps pipelines**
- Ability to integrate **SAST and container scanning**
- Knowledge of **security gates** in CI/CD to prevent critical vulnerabilities
- Strong awareness of **how Dockerfile changes impact security posture**

---

This repository is designed as a **professional DevSecOps portfolio piece** to demonstrate the practical application of security-first CI/CD workflows to recruiters and engineering teams.
