output "public_ip" {
    description = "printing publicip"
    value = aws_instance.nginx[*].public_ip
}

output "instance_id" {
    description = "printing instance id"
    value = aws_instance.nginx[*].id
}