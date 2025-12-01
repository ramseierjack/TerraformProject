resource "kubernetes_horizontal_pod_autoscaler" "nginx" {
  metadata {
    name      = "nginx-hpa"
    namespace = kubernetes_namespace.demo.metadata[0].name
  }

  spec {
    min_replicas = 1
    max_replicas = 5
    target_cpu_utilization_percentage = 50

    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = kubernetes_deployment.nginx.metadata[0].name
    }
  }
}