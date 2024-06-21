resource "google_artifact_registry_repository" "my_repo" {
  provider         = google
  location         = var.region
  repository_id    = "my-repo-kumar3"
  description      = "Docker repository"
  format           = "DOCKER"
  project          = var.project_id
}

resource "null_resource" "docker_build_and_push" {
  provisioner "local-exec" {
    command = <<EOT
       
       docker build -t ${google_artifact_registry_repository.my_repo.location}-docker.pkg.dev/${var.project_id}/my-repo-kumar3/my-image1:v1 .
       docker tag ${google_artifact_registry_repository.my_repo.location}-docker.pkg.dev/${var.project_id}/my-repo-kumar3/my-image1:v1 ${google_artifact_registry_repository.my_repo.location}-docker.pkg.dev/${var.project_id}/my-repo-kumar2/my-image1:latest
       docker push ${google_artifact_registry_repository.my_repo.location}-docker.pkg.dev/${var.project_id}/my-repo-kumar3/my-image1:v1
    EOT
    environment = {
      GOOGLE_APPLICATION_CREDENTIALS = "./key.json"
    }
  }


  triggers = {
    docker_image = "${google_artifact_registry_repository.my_repo.location}-docker.pkg.dev/${var.project_id}/my-repo-kumar3/my-image1:v1"
  }

  depends_on = [google_artifact_registry_repository.my_repo]
}

output "docker_image_url" {
  value = null_resource.docker_build_and_push.triggers.docker_image
}

#cloudrun



resource "google_cloud_run_service" "default" {
  name     = "cloudrun-srv2"
  location = "us-central1"
  project  = "graphite-lamp-421814"

  template {
    spec {
      service_account_name = "cloud-run@graphite-lamp-421814.iam.gserviceaccount.com"  # Correct service account
      containers {
        name  = "hello-1"
        ports {
          container_port = 80
        }
        image = null_resource.docker_build_and_push.triggers.docker_image
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
  depends_on = [null_resource.docker_build_and_push]
}


resource "google_cloud_run_service" "hello-world" {
  name     = "hello-world"
  location = "us-central1"
  project  = "graphite-lamp-421814"

  template {
    spec {
      service_account_name = "cloud-run@graphite-lamp-421814.iam.gserviceaccount.com"  # Correct service account
      containers {
        name  = "hello-world"
        ports {
          container_port = 80
        }
        image = "gcr.io/cloudrun/hello"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_policy" "noauth1" {
  location = google_cloud_run_service.hello-world.location
  project  = google_cloud_run_service.hello-world.project
  service  = google_cloud_run_service.hello-world.name

  policy_data = data.google_iam_policy.noauth.policy_data
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_service.default.location
  project  = google_cloud_run_service.default.project
  service  = google_cloud_run_service.default.name

  policy_data = data.google_iam_policy.noauth.policy_data
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}


output "cloudrun_srv2_url" {
  value = google_cloud_run_service.default.status[0].url
}

output "hello_world_url" {
  value =  replace(google_cloud_run_service.hello-world.status[0].url, "https://", "")
}
