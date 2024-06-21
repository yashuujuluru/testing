


resource "null_resource" "deploy_openapi" {
  provisioner "local-exec" {
    command = <<EOT
      gcloud endpoints services deploy ${path.module}/open-api.yaml --project ${var.project_id}
    EOT
  }

}






