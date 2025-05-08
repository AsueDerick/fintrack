output "application_url" {
  description = "URL to access the Fintrack application"
  value       = "http://${aws_instance.fintrack.public_dns}:5001"
}