# Anthony Abia | DevOps & Cloud Engineering Portfolio

Welcome to my DevOps and Cloud Engineering portfolio. This repository showcases my hands-on projects in Linux administration, CI/CD automation, containerization, infrastructure operations, and cloud engineering.

I am transitioning from Electrical/Electronics Engineering into technology, with a focus on building reliable infrastructure, automating software delivery, and developing practical cloud and DevOps skills.

My approach combines hands-on implementation, troubleshooting, documentation, and continuous learning.

## Technical Skills

| Category | Technologies |
|---|---|
| Version Control | Git, GitHub, GitLab |
| Operating Systems | Linux, Ubuntu |
| Containers | Docker, Docker Compose |
| Container Orchestration | Kubernetes, kind |
| CI/CD | Jenkins |
| Infrastructure as Code | Terraform |
| Cloud Platforms | AWS fundamentals: EC2, VPC, S3 |
| Build Tools | Maven |
| Scripting and Automation | Bash, PowerShell fundamentals |
| Virtualization | VMware Workstation |

## Featured Projects

### 1. Local AWS EC2 CI/CD Simulation Lab

**A practical CI/CD pipeline using Jenkins, Maven, Docker, Docker Hub, and VMware-hosted Ubuntu virtual machines.**

This project demonstrates how a software application can move through a build, test, packaging, containerization, image publishing, and deployment workflow in a local lab environment.

Instead of deploying to a paid AWS EC2 instance, the lab uses a dedicated Ubuntu virtual machine as the deployment target while practicing concepts relevant to remote-server deployments.

**Key activities:**
- Configured a Jenkins pipeline for application checkout and build automation.
- Used Maven to build the Java application and run unit tests.
- Built a Docker image and published it to Docker Hub.
- Used SSH-based deployment concepts to deploy the application to a separate Ubuntu virtual machine.
- Documented the architecture, deployment process, troubleshooting, and lessons learned.
- Captured screenshots showing the pipeline stages and deployment results.

**Technologies:** Jenkins, Git, Maven, Java, Docker, Docker Compose, Docker Hub, SSH, Linux, VMware.

**Explore the project:**
- [Project README](03-Cloud-and-CI-CD/Local-aws-ec2-CI-CD-Lab/README.md)
- [Jenkins Pipeline](03-Cloud-and-CI-CD/Local-aws-ec2-CI-CD-Lab/Jenkinsfile)
- [Dockerfile](03-Cloud-and-CI-CD/Local-aws-ec2-CI-CD-Lab/Dockerfile)
- [Docker Compose Configuration](03-Cloud-and-CI-CD/Local-aws-ec2-CI-CD-Lab/docker-compose.yml)
- [Architecture Documentation](03-Cloud-and-CI-CD/Local-aws-ec2-CI-CD-Lab/docs/architecture.md)
- [Deployment Guide](03-Cloud-and-CI-CD/Local-aws-ec2-CI-CD-Lab/docs/deployment-guide.md)
- [Troubleshooting Guide](03-Cloud-and-CI-CD/Local-aws-ec2-CI-CD-Lab/docs/troubleshooting.md)
- [Lessons Learned](03-Cloud-and-CI-CD/Local-aws-ec2-CI-CD-Lab/docs/lessons-learned.md)
- [Pipeline and Deployment Screenshots](03-Cloud-and-CI-CD/Local-aws-ec2-CI-CD-Lab/screenshots/)

### 2. VMware Infrastructure Migration and Linux Disk Expansion

This project documents the migration of three Ubuntu virtual machines from a laptop's internal storage to an external hard drive, followed by expanding a Linux root partition and filesystem.

**Key activities:**
- Migrated VMware virtual-machine folders using Windows PowerShell.
- Verified migrated virtual machines and their configuration files.
- Expanded a virtual disk from 20 GiB to 40 GiB.
- Extended a Linux root partition using `growpart`.
- Resized the ext4 filesystem using `resize2fs`.
- Troubleshot disk-space and boot-related issues.
- Documented verification commands and operational precautions.

**Result:** Expanded the `dev-server` root filesystem to approximately 30 GB, with approximately 19.2 GB available after the operation.

**Project documentation:**
- [Project Overview](02-DevOps-Infrastructure-Operations/01-VMware-Migration-and-Linux-Disk-Expansion/README.md)
- [Migration Process](02-DevOps-Infrastructure-Operations/01-VMware-Migration-and-Linux-Disk-Expansion/migration-process.md)
- [PowerShell Migration Commands](02-DevOps-Infrastructure-Operations/01-VMware-Migration-and-Linux-Disk-Expansion/migration-powershell.md)
- [Linux Disk Expansion](02-DevOps-Infrastructure-Operations/01-VMware-Migration-and-Linux-Disk-Expansion/disk-expansion.md)
- [Troubleshooting Notes](02-DevOps-Infrastructure-Operations/01-VMware-Migration-and-Linux-Disk-Expansion/troubleshooting.md)

### 3. Linux Administration Lab

A collection of practical Linux administration exercises focused on command-line operations, system monitoring, scripting, and troubleshooting.

**Focus areas:**
- Linux command-line fundamentals.
- System monitoring and resource inspection.
- Bash scripting.
- Basic administration and troubleshooting.

**Project directory:** [`01-Linux-Administration-Lab/`](01-Linux-Administration-Lab/)

### 4. Local AWS CI/CD Simulation Guide

An additional guide documenting the concepts behind building a local CI/CD laboratory that simulates aspects of an AWS EC2 deployment workflow.

**Project directory:** [`My-Local-AWS-EC2-CICD-Simulation-Lab/`](My-Local-AWS-EC2-CICD-Simulation-Lab/)

## Engineering Approach

My learning process emphasizes:

- Understanding the underlying technology rather than simply copying commands.
- Building and testing practical solutions.
- Troubleshooting failures systematically.
- Automating repeatable tasks.
- Documenting technical procedures clearly.
- Improving reliability, security, and maintainability.

These projects represent practical lab work and ongoing professional development. I aim to continue strengthening my skills through increasingly challenging projects and collaboration with experienced engineers.

## Career Objective

I am seeking junior DevOps Engineer, Cloud Operations, and Infrastructure Support opportunities where I can contribute my existing technical foundation, learn from experienced engineers, and grow through practical engineering work.

## Connect

- **GitHub:** [A-Tony1](https://github.com/A-Tony1)

*Learning continuously. Automating thoughtfully. Building reliable infrastructure.*
