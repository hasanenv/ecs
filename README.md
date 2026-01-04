# Gatus Monitoring Platform on AWS (ECS Fargate, Terraform, CI/CD)

![AWS](https://img.shields.io/badge/AWS-ECS%20Fargate-orange)
![Terraform](https://img.shields.io/badge/Terraform-IaC-purple)
![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-CI%2FCD-blue)
![Docker](https://img.shields.io/badge/Docker-Containers-blue)
![OIDC](https://img.shields.io/badge/Security-OIDC-green)
![IAM](https://img.shields.io/badge/IAM-Least%20Privilege-red)

<p align="center">
  <img src="assets/ecs-diagram.png" width="1300">
</p>

---

## Table of Contents

- [Overview](#overview)
- [Design Priorities](#design-priorities)
- [Architecture Overview](#architecture-overview)
- [Repository Structure](#repository-structure)
- [CI/CD Workflow](#cicd-workflow)
- [Containers & Runtime](#containers--runtime)
- [IAM & Least Privilege Access](#iam--least-privilege-access)
- [Terraform & State Management](#terraform--state-management)
- [Observability](#observability)
- [Cost & Availability Decisions](#cost--availability-decisions)
- [What This Project Demonstrates](#what-this-project-demonstrates)

## Overview

A **production-grade container platform** built on AWS using **ECS Fargate**, **Terraform**, and **GitHub Actions**.

The platform focuses on **infrastructure design, security, and deployment automation**, with an emphasis on architectural clarity, safe delivery, and operational correctness.

## Design Priorities

- Infrastructure defined as code
- Secure CI/CD using OIDC, eliminating need for long-lived credentials
- Principle of least privilege applied consistently
- Immutable container deployments
- Explicit availability and cost tradeoffs

## Architecture Overview

### Gatus UI Running Behind ALB

<p align="center">
  <img src="assets/gatus-demo.gif" width="1200">
</p>

The platform runs in a custom VPC spanning two Availability Zones and follows standard AWS production patterns:

- Public subnets hosting an Application Load Balancer
- Private subnets running ECS Fargate tasks
- HTTPS and HTTP redirect enforced using ACM and Route 53
- Runtime configuration stored in **SSM Parameter Store**
- Centralised logging via CloudWatch
- Provisioned and managed through Terraform

## Repository Structure

```
ecs
├─ .github/
│  └─ workflows/
│     └─ ci-cd.yml
├─ app/
│  └─ gatus/
│     ├─ Dockerfile
│     ├─ entrypoint.sh
│     └─ .dockerignore
├─ assets/
│  ├─ ecs-diagram.png
│  ├─ gatus-demo.gif
│  ├─ cicd-summary.png
│  └─ job-summary.png
├─ infra/
│  ├─ main.tf
│  ├─ provider.tf
│  ├─ variables.tf
│  ├─ outputs.tf
│  ├─ locals.tf
│  ├─ data.tf
│  ├─ ssm.tf
│  ├─ .terraform.lock.hcl
│  ├─ config/
│  │  └─ config.yaml
│  └─ modules/
│     ├─ acm/
│     │  ├─ main.tf
│     │  ├─ variables.tf
│     │  ├─ outputs.tf
│     │  └─ locals.tf
│     ├─ alb/
│     │  ├─ main.tf
│     │  ├─ variables.tf
│     │  ├─ outputs.tf
│     │  └─ locals.tf
│     ├─ ecr/
│     │  ├─ main.tf
│     │  ├─ variables.tf
│     │  ├─ outputs.tf
│     │  └─ locals.tf
│     ├─ ecs/
│     │  ├─ main.tf
│     │  ├─ variables.tf
│     │  ├─ outputs.tf
│     │  └─ locals.tf
│     ├─ iam/
│     │  ├─ main.tf
│     │  ├─ variables.tf
│     │  ├─ outputs.tf
│     │  └─ locals.tf
│     ├─ route53/
│     │  ├─ main.tf
│     │  ├─ variables.tf
│     │  └─ outputs.tf
│     ├─ security-groups/
│     │  ├─ main.tf
│     │  ├─ variables.tf
│     │  ├─ outputs.tf
│     │  └─ locals.tf
│     └─ vpc/
│        ├─ main.tf
│        ├─ variables.tf
│        ├─ outputs.tf
│        └─ locals.tf
├─ .gitignore
├─ LICENSE
└─ README.md
```

## CI/CD Workflow

> [!IMPORTANT]
> CI is treated as a hard gate. No infrastructure changes or deployments occur unless all validation steps succeed.

CI runs on every push and pull request and performs automated validation:

- Docker image build for verification  
- Terraform formatting, linting, and static checks  

CD runs only after CI succeeds (`needs`):

- Authenticates to AWS using OIDC (no long lived credentials)  
- Builds and tags images immutably  
- Applies Terraform and updates ECS task definitions  

### CI/CD Successful Run
<p align="center">
  <img src="assets/cicd-summary.png" width="700">
</p>

### Deployment Summary
<p align="center">
  <img src="assets/job-summary.png" width="700">
</p>

## Containers & Runtime

- Multi-stage Docker build strips out tooling and reduces image size
- Explicit non-root user enforcing least privilege at runtime
- Reduced attack surface by removing unused binaries, package managers, and shells

## IAM & Least Privilege Access

> [!NOTE]
> IAM policies are intentionally scoped to the minimum permissions required for each role.

Access control is a foundational part of the platform design:

- Dedicated CI/CD role with scoped read and apply permissions  
- Separate ECS task execution role limited to runtime needs  
- All IAM configuration managed in Terraform to prevent drift

## Terraform & State Management

- Modular structure for clarity and reuse
- Remote Terraform state stored in S3
- State locking via DynamoDB

## Observability

- ECS task logs shipped to CloudWatch
- Log groups created and managed via Terraform
- No manual logging configuration or console setup required

---

## Cost & Availability Decisions

> [!NOTE]
> Cost optimisations are applied only where they do not affect customer facing availability.

Some design choices reflect deliberate tradeoffs:

- High availability on ingress paths (ALB, multi AZ), while NAT is single AZ by design
- Single NAT Gateway chosen to control cost on outbound traffic
- ECS Fargate avoids EC2 operational overhead

---

## What This Project Demonstrates

- Production-minded AWS architecture
- Secure CI/CD using modern authentication patterns
- Infrastructure that is easy to reason about and audit
- Clear separation of concerns

This repository represents a realistic container platform, built under the same constraints and considerations found in production environments.
