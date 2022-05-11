service {
  name = "backend-service"
  id = "backend-service"
  port = 9080

  connect {
    sidecar_service {}
  }

  check {
    id = "backend-service-check"
    http = "http://localhost:9080"
    method = "GET"
    interval = "1s"
    timeout = "1s"
  }
}
