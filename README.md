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
-- 8080 for frontend
-- 3000 for Grafana

