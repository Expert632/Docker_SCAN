# 🔐 End-to-End DevSecOps Lab: Docker + SAST + Trivy + Security Gate

This repository showcases a **complete, realistic DevSecOps workflow** built around Docker images, static analysis, and container vulnerability scanning – with a dedicated **Security Gate** that blocks builds when critical vulnerabilities are detected.

The goal of this project is both **technical** and **pedagogical**:
- Demonstrate how to integrate security **early and continuously** in the CI pipeline.
- Show a **clear, visual progression**: from a clean Docker image ➝ to an image with injected vulnerabilities ➝ to a failing security gate.
- Provide a concrete example that recruiters and engineering teams can easily understand and reuse.

---

## 🧭 High-Level Overview

This lab is built around three main axes:

1. **Docker Hardening & Vulnerability Management**
   - Start with a **Dockerfile without known critical vulnerabilities**.
   - Use **Trivy** to scan the Docker image and generate machine-readable reports.
   - Intentionally **inject a critical vulnerability** and observe how the scanning results change.

2. **Static Application Security Testing (SAST)**
   - Implement a **Practical SAST pipeline using Semgrep**.
   - Show how SAST fits into CI pipelines and complements container scanning.

3. **Security Gate for CI/CD**
   - Add a dedicated **Security Gate pipeline**.
   - The gate reads the JSON report from Trivy and:
     - Allows the pipeline to pass when no critical vulnerabilities are found.
     - Fails the pipeline when a **critical vulnerability** is detected.

---

## 🏗 Step-by-Step Journey

### 1. Creation of a New Repository

I started by creating a **fresh GitHub repository** dedicated to this lab:

- Organized with a clear structure:
  - `Dockerfile` (or multiple Dockerfiles)
  - `.github/workflows/` for all pipelines
  - `reports/` (optional) for local scan outputs
- Enabled **GitHub Actions** for CI/CD.

> ✅ Goal: simulate a real-world environment where each push triggers security checks.

---

### 2. Validation of the Baseline Setup

Before introducing any security tooling, I validated the basic CI/CD flow:

- Ensured that:
  - The repository builds successfully.
  - The base Docker image can be built without errors.
  - GitHub Actions workflows trigger as expected.

> ✅ Goal: start from a **clean, stable baseline** before adding security layers.

---

### 3. Creation of Dockerfiles Without Vulnerabilities

Initially, I implemented **Dockerfiles with a focus on best practices**:

- Use of **official base images**.
- Minimal install of packages.
- No intentionally vulnerable versions or outdated distributions at this stage.

Examples of improvements:
- Avoiding unnecessary tools in production images.
- Reducing the image attack surface where possible.

> ✅ Goal: show a **"good citizen" Docker image** and use it as a baseline for security scans.

---

### 4. Pipeline 01 – Practical SAST with Semgrep

Next, I implemented **Pipeline 01: SAST using Semgrep**.

Key characteristics:

- Uses **Semgrep** to scan the codebase for:
  - Insecure coding patterns.
  - Potential injection points.
  - Common web vulnerabilities (depending on ruleset).
- Integrated as a **GitHub Actions workflow**, running on:
  - `push` to main branches.
  - `pull_request` events for code review.

Highlights:
- Uses open-source Semgrep rules (and can be extended with custom rules).
- Results are exposed directly in the CI logs and can be exported as reports.

> ✅ Goal: demonstrate how **SAST** fits into CI and complements container scanning.

---

### 5. Trivy Scan – Image Without Critical Vulnerabilities

Once the Docker images were built from the **initial, clean Dockerfiles**, I:

- Ran **Trivy** against the Docker image as part of the CI pipeline.
- Limited the severity to **HIGH and CRITICAL** for more meaningful signal.
- Confirmed that **no critical vulnerabilities** were detected at this stage.

Expected behavior:
- The pipeline prints something like:  
  `No critical vulnerability detected`
- The Docker image is considered "acceptable" from a critical-severity standpoint.

> ✅ Goal: show a **positive case** where the image passes security checks.

---

### 6. Generation of JSON Report

To make the results **machine-readable and automatable**, I:

- Configured Trivy to generate a **JSON report**:
  - Example filename: `scan-report.json`.
- Optionally generated a **TXT/table report** for human inspection:
  - Example filename: `scan-report.txt`.

These reports are:
- Stored as **artifacts in GitHub Actions**, or
- Committed to a `reports/` directory for offline analysis (depending on the setup).

> ✅ Goal: prepare the groundwork for the **Security Gate**, which consumes the JSON report.

---

### 7. Modification of Dockerfiles to Inject a Critical Vulnerability

To simulate a real-world scenario where new changes introduce risk, I:

- **Modified the Dockerfiles** to:
  - Use **older, end-of-life base images** (e.g., outdated Ubuntu versions), and/or
  - Install **outdated packages** with known vulnerabilities.

Examples of typical injections:
- Switching from a supported base image to an **EOL distribution**.
- Installing known vulnerable versions of:
  - `openssl`
  - web servers or scripting engines
  - other libraries with a history of CVEs.

> 🎯 This was done **intentionally for educational purposes**, to show how the security posture can degrade due to seemingly small changes.

---

### 8. Trivy Scan – Image With Critical Vulnerability

After modifying the Dockerfiles:

- I re-ran the Trivy scan as part of the same pipeline.
- This time, the scanner **detected at least one critical vulnerability** in the image.

Expected behavior:
- The logs show a clear change of state, e.g.:
  - Before: `No critical vulnerability detected`
  - After: `Critical vulnerability detected`
- The JSON report now includes entries with: `"Severity": "CRITICAL"`.

> ✅ Goal: demonstrate how **a single change** in the Dockerfile can push the image from "safe enough" to "high risk".

---

### 9. Creation of Pipeline 02 – Security Gate

With reliable JSON reports from Trivy, I created **Pipeline 02: Security Gate**.

Key responsibilities of this pipeline:

- **Read the Trivy JSON report** generated by the previous pipeline.
- Parse the vulnerabilities and **check for any CRITICAL entries**.
- Act as an explicit **“Go / No-Go” decision point** for the build or deployment.

Implementation details:
- Implemented as a **separate GitHub Actions workflow**.
- Fails with `exit 1` when:
  - At least one vulnerability of severity **CRITICAL** is found.
- Passes when:
  - No CRITICAL vulnerabilities are present.

> ✅ Goal: enforce security as a **first-class citizen** in the CI/CD lifecycle.

---

### 10. Display Red Pipeline 03 After Detecting the Critical Vulnerability

Finally, I showcased the full effect of the Security Gate:

- The initial scanning pipeline (Pipeline 01: SAST + Trivy) can remain **green** for educational purposes, even when vulnerabilities exist (depending on configuration).
- **Pipeline 02 (Security Gate)** turns **red** when:
  - The modified, vulnerable Dockerfile is scanned,
  - The Trivy JSON report contains at least one CRITICAL vulnerability.

From a recruiter’s/engineering manager’s perspective:

- This visually demonstrates:
  - A **mature DevSecOps mindset**.
  - The ability to design **multi-stage pipelines**:
    - Informational scans,
    - Hard security gates,
    - Gradual rollout of security rules.

> ✅ Goal: show a realistic **“shift left” security approach** with clear, automated gates.

---

## 🧪 Tools & Technologies

- **Docker** – Containerization and image hardening.
- **Trivy** – Container image vulnerability scanning (open source).
- **Semgrep** – Static Application Security Testing (SAST).
- **GitHub Actions** – CI/CD pipelines, artifact storage, and workflow orchestration.
- **YAML-based pipelines** – Reproducible, portable, and easy to review.

---

## 🚀 What This Project Demonstrates

By walking through this lab, I demonstrate:

- My ability to:
  - Design and structure **security-focused CI/CD pipelines**.
  - Integrate **SAST (Semgrep)** and **container scanning (Trivy)**.
  - Implement a **Security Gate** that enforces policy based on scan results.
- My understanding of:
  - The difference between **informational pipelines** and **blocking gates**.
  - The impact of Dockerfile changes on the **security posture** of an image.
  - How to **automate security checks** in a scalable and repeatable way.

---

## 💼 For Recruiters & Hiring Managers

This repository is intentionally built as a **practical DevSecOps portfolio piece**.

It shows that I can:

- Go beyond “Hello World” CI pipelines.
- Think in terms of **security outcomes**, not just tools.
- Build **end-to-end flows**:
  - From repository creation ➝ through SAST ➝ to image scanning ➝ to security gating.

If you’d like to discuss how this approach can be adapted to your own stack (GitLab CI, Jenkins, Azure DevOps, etc.), I’d be happy to walk you through the architecture and trade-offs.

---
