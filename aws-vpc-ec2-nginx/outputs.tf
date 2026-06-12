
output "instance_public_ip" {
  description = "Public IP of ec2 instance"
  value = aws_instance.nginxserver.public_ip
}

output "instance-url" {
  description = "The URL to access ngnix server via ec2 instance"
  value = "http://${aws_instance.nginxserver.public_ip}"
}