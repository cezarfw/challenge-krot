data "template_file" "policy" {
  template = file("templates/policy.json.tpl")
  vars = {
    bucket_name = "${var.name}-nginxlogs"
  }
}

resource "aws_s3_bucket" "kroton-nginx-logs" {
  bucket = "${var.name}-nginxlogs"
  acl    = "private"

  tags = var.tags
}
