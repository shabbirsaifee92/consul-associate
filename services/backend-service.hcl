service {
  name = "backend-service"
  id = "backend-service"
  port = 9080

  connect {
    sidecar_service {}
  }

  check {
    id = "backend-service-check"
    http = "http://127.0.0.1:9080"
    method = "GET"
    interval = "1s"
    timeout = "1s"
  }
}
