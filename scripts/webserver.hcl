job "webserver" {
  type = "service"
  datacenter = ["dc1"]
  group "webserver" {

    task "webserver" {
      driver = "docker"

      config {
        image = "httpd"
        force_pull = true
        port_map = {
          webserver_web = 80
        }
        logging {
          type = "journald"
          config {
            tag = "WEBSERVER"
          }
        }
      }

      service {
        name = "webserver"
        port = "webserver_web"
      }

      resources {
        network {
          port "webserver_web" {
            static = 8000
          }
        }
      }
    }
  }
}

