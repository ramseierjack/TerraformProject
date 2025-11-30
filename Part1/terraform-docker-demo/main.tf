terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_network" "demo_network" {
  name = "demo_network"
}

# Postgres
resource "docker_image" "postgres_image" {
  name = "postgres:15"
}

resource "docker_volume" "postgres_data" {
  name = "postgres_data"
}

resource "docker_container" "postgres" {
  name  = "postgres_container"
  image = docker_image.postgres_image.image_id

  networks_advanced {
    name = docker_network.demo_network.name
  }

  env = [
    "POSTGRES_USER=demo",
    "POSTGRES_PASSWORD=demo123",
    "POSTGRES_DB=demo_db"
  ]

  volumes {
    volume_name    = docker_volume.postgres_data.name
    container_path = "/var/lib/postgresql/data"
  }
}
resource "docker_image" "backend_image" {
  name = "my-backend:latest"
}

resource "docker_container" "backend" {
  name  = "backend_container"
  image = docker_image.backend_image.image_id

  networks_advanced {
    name = docker_network.demo_network.name
  }

  env = [
    "DB_HOST=postgres_container",
    "DB_USER=demo",
    "DB_PASSWORD=demo123",
    "DB_NAME=demo_db"
  ]

  ports {
    internal = 5000
    external = 5000
  }
}

resource "docker_image" "nginx_image" {
  name = "nginx:latest"
}

resource "docker_container" "nginx" {
  name  = "nginx_container"
  image = docker_image.nginx_image.image_id

  networks_advanced {
    name = docker_network.demo_network.name
  }

  ports {
    internal = 80
    external = 8080
  }

  volumes {
  host_path      = "/home/ubuntu/terraform-docker-demo/nginx.conf"
  container_path = "/etc/nginx/conf.d/default.conf"
  }
}

resource "docker_volume" "grafana_data" {
  name = "grafana_data"
}

resource "docker_image" "grafana_image" {
  name = "grafana/grafana:latest"
}

resource "docker_container" "grafana" {
  name  = "grafana_container"
  image = docker_image.grafana_image.image_id

  networks_advanced {
    name = docker_network.demo_network.name
  }

  ports {
    internal = 3000
    external = 3000
  }

  volumes {
    volume_name    = docker_volume.grafana_data.name
    container_path = "/var/lib/grafana"
  }
}

