provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "vite_react_app" {
  metadata {
    name = "vite-react-app"
    labels = {
      app = "vite-react-app"
    }
  }
  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "vite-react-app"
      }
    }
    template {
      metadata {
        labels = {
          app = "vite-react-app"
        }
      }
      spec {
        container {
          image = "sharl1/your-app:latest"
          name  = "vite-react-app"
          ports {
            container_port = 3000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "vite_react_app_service" {
  metadata {
    name = "vite-react-app-service"
  }
  spec {
    selector = {
      app = "vite-react-app"
    }
    port {
      port        = 80
      target_port = 3000
    }
    type = "LoadBalancer"
  }
}

resource "kubernetes_ingress" "vite_react_app_ingress" {
  metadata {
    name = "vite-react-app-ingress"
    annotations = {
      "nginx.ingress.kubernetes.io/rewrite-target" = "/"
    }
  }
  spec {
    rule {
      host = "your-app.example.com"
      http {
        path {
          path = "/"
          backend {
            service {
              name = kubernetes_service.vite_react_app_service.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}
