# 🛠️ Self-Healing Infrastructure using Prometheus, Alertmanager & Ansible

## 🚀 Project Overview
This project demonstrates a **self-healing infrastructure** that can automatically detect when a service (in this case, **NGINX**) goes down and recover it without manual intervention.

Using **Prometheus**, **Alertmanager**, and **Ansible**, the system continuously monitors NGINX’s availability.  
When Prometheus detects that NGINX is unreachable, it triggers an alert via Alertmanager, which sends a webhook request to a custom listener script.  
That webhook runs an **Ansible playbook** that restarts the NGINX container automatically — achieving complete **auto-recovery**.

---

## 🎯 Objective
Build a simple infrastructure that:
- Monitors the health of a running service (NGINX)
- Detects failures in real time using Prometheus
- Triggers alerts via Alertmanager
- Automatically heals the failed service using Ansible

---

## ⚙️ Tools & Technologies
| Tool | Purpose |
|------|----------|
| **AWS EC2 (Ubuntu 22.04)** | Cloud host for the setup |
| **Docker & Docker Compose** | Container management |
| **Prometheus** | Monitoring & alert generation |
| **Alertmanager** | Alert routing and notification |
| **Ansible** | Automated recovery playbook |
| **Shell Scripting (Webhook)** | Custom listener for alert triggers |

---

## 🧱 Architecture
```text
+-------------+       +----------------+       +----------------+       +----------------------+
|   NGINX     | ----> |   Prometheus   | ----> |  Alertmanager  | --->  | Webhook + Ansible    |
| (Monitored) |       | (Detects Down) |       | (Sends Alerts) |       | (Restarts Container) |
+-------------+       +----------------+       +----------------+       +----------------------+
