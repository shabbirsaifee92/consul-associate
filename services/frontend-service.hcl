service {
  name = "frontend-service"
  port = 8080

  connect {
    sidecar_service {
      proxy {
        upstreams = [
          {
            destination_name = "backend-service"
            local_bind_port = 5000
          }
        ]
      }
    }
  }

  check {
    id = "frontend-service-check"
    http = "http://localhost:8080"
    method = "GET"
    interval = "1s"
    timeout = "1s"
  }
}
