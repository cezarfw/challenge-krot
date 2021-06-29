output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.web.id
}

output "instance_arn" {
  value = aws_instance.web.arn
}

output "instance_dns" {
  value = aws_instance.web.public_dns
}

output "instance_public_ip" {
  value = aws_instance.web.public_ip
}

output "instance_private_ip" {
  value     = aws_instance.web.private_ip
  sensitive = true
}

output "bucket_nginx_logs" {
  value = aws_s3_bucket.kroton-nginx-logs.bucket_domain_name
}
