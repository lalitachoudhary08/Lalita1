output "name" {
  value       = ""
  sensitive   = true
  description = "description"
  depends_on  = []
}

output "ami-id" {
  description = "print ami-id"
  value       = data.aws_ami.amazon.id
}

output "public-ip" {
  description = "print public-ip"
  value       = resource.aws_instance.web.public_ip

}

# output "name" {
#   description = "print name"
#   value = resource.aws_instance.web.instance.id

# }  