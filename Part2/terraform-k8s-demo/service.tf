resource "kubernetes_service" "nginx" {
  metadata {
    name      = "nginx-service"
    namespace = kubernetes_namespace.demo.metadata[0].name
    labels = {
      app = "nginx"
    }
  }

  spec {
    selector = {
      app = "nginx"
    }

    port {
      name        = "http"   # required unique name
      port        = 80       # service port
      target_port = 80       # container port
    }

    type = "ClusterIP"       # internal-only access
  }
}
