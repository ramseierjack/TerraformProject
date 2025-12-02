# TerraformProject
2 different implementations of containres, built using terraform.

# Part 1 - Docker
This project implements the following services with Docker, managed by Terraform:
- Postgres for persistent relational data
- Backend Python Flask app that queries Postgres
- Nginx reverse proxy exposing the backend to the host network
- Grafana for dashboards and visualization

Key files explained
- main.tf: Terraform configuration for Docker network, containers, volumes, and optional      monitoring.
- nginx.conf: Nginx reverse proxy configuration forwarding to the backend.
- backend/app.py: Flask application that connects to Postgres and exposes API endpoints.
- backend/Dockerfile: Builds the my-backend:latest image used by Terraform.
- scripts/seed_db.sql: SQL used to create tables and seed sample data (Part 2).

Deployment:
- Build backend image
- Initialize and apply Terraform
- Ensure ports are open:
- - 8080 for frontend
- - 3000 for Grafana


# Part 2 - Kubernetes
This part of the project demonstrates deployment of a number of tools in the form of a Kubernetes cluster

Tools Implemented:
- nginx
- Ingress
- HPA

Key Files:
- provider.tf: Configures the Terraform Kubernetes provider and any required provider settings so Terraform can talk to your cluster.
- namespace.tf: Declares the demo-namespace Kubernetes Namespace resource that scopes all demo resources.
- deployment.tf: Creates the nginx Deployment with the requested replica count.
- service.tf: Exposes the nginx pods inside the cluster (ClusterIP) or externally (NodePort) depending on the type you choose.
- ingress.tf: Defines an Ingress resource so Traefik (or another ingress controller) can route external HTTP(S) traffic to the nginx Service.
- hpa.tf: Adds a Horizontal Pod Autoscaler to automatically scale the nginx Deployment based on CPU utilization.

Deployment:
- Create namespace
- Create deployment with 1 replica
- Create service
- Create Ingress
- Initialize and Apply Terraform
- Add HPA
- Ensure ports are open:
- - 80