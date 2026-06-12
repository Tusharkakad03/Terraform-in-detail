
resource "aws_instance" "nginxserver" {

    ami = "ami-0fe18bc3cfa53a248"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.public_subnet.id
    vpc_security_group_ids = [ aws_security_group.nginx_sg.id ]
    associate_public_ip_address = true

    user_data = <<-EOF
                #!/bin/bash
                sudo apt-get update
                sudo apt-get install nginx -y
                sudo systemctl start nginx
                sudo systemctl enable nginx 
                EOF

    tags = {
        Name = "Nginx-Server"
    }
}
