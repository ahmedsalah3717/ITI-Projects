

data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"]
}





resource "aws_instance" "public-ec2-1" {
    
    ami = data.aws_ami.ubuntu.id
    instance_type = var.ec2-type

  
    key_name = "lab-1-terra"
    vpc_security_group_ids = [var.public-ec2-sg-id]
    subnet_id = var.public-subnet-ids["public-1"]
    associate_public_ip_address = true

    provisioner "remote-exec" {
        inline = [
            "sudo apt update -y",
            "sudo apt install nginx -y ",
            "echo 'server { \n listen 80 default_server; \n  listen [::]:80 default_server; \n  server_name _; \n  location / { \n  proxy_pass http://${var.private-load-balancer-dns}; \n  } \n}' > default",
            "sudo mv default /etc/nginx/sites-enabled/default",
            "sudo systemctl restart nginx",
            "sudo apt install curl -y",
        ]

        connection {
            host        = self.public_ip
            type        = "ssh"
            user        = "ubuntu"
            private_key = file("/home/ahmed/DevOps journey/ITI/terraform/project/project/lab-1-terra.pem")
        }
        
    }
    provisioner "local-exec" {
        command = "echo Public-ip : ${self.public_ip} >> all-ips.txt"
    }


    tags = {
        Name = "iti-proxy-ec2-public-1"
    }


}



resource "aws_instance" "public-ec2-2" {
    
    ami = data.aws_ami.ubuntu.id
    instance_type = var.ec2-type
    ###########
    key_name = "lab-1-terra"
    vpc_security_group_ids = [var.public-ec2-sg-id]
    subnet_id = var.public-subnet-ids["public-2"]
    associate_public_ip_address = true

    provisioner "remote-exec" {
        inline = [
            "sudo apt update -y",
            "sudo apt install nginx -y ",
            "echo 'server { \n listen 80 default_server; \n  listen [::]:80 default_server; \n  server_name _; \n  location / { \n  proxy_pass http://${var.private-load-balancer-dns}; \n  } \n}' > default",
            "sudo mv default /etc/nginx/sites-enabled/default",
            "sudo systemctl restart nginx",
            "sudo apt install curl -y",
        ]
########
        connection {
            host        = self.public_ip
            type        = "ssh"
            user        = "ubuntu"
            private_key = file("/home/ahmed/DevOps journey/ITI/terraform/project/project/lab-1-terra.pem")
        }
        
    }

    provisioner "local-exec" {
        command = "echo public-ip : ${self.public_ip} >> all-ips.txt"
    }


    tags = {
        Name = "iti-proxy-ec2-public-2"
    }


}






resource "aws_instance" "private-ec2s" {

    for_each = var.private-subnet-ids
    ami           =  data.aws_ami.ubuntu.id
    
    instance_type = var.ec2-type
    
    subnet_id     = each.value
    

    vpc_security_group_ids = [var.private-ec2-sg-id]
    
    user_data = file("ec2/ec2-userdata.sh")

    provisioner "local-exec" {
        command = "echo private-ip : ${self.private_ip} >> all-ips.txt"
    }
    
    tags = {
      Name = "iti-ec2-${each.key}"
    }
  
}


resource "aws_alb_target_group_attachment" "public-target-group-attachment1" {
  target_group_arn = var.public-tg-arn
  target_id = aws_instance.public-ec2-1.id
  port = 80
}

resource "aws_alb_target_group_attachment" "public-target-group-attachment2" {
  target_group_arn = var.public-tg-arn
  target_id = aws_instance.public-ec2-2.id
  port = 80
}

resource "aws_alb_target_group_attachment" "private-target-group-attachment1" {
  target_group_arn = var.private-tg-arn
  target_id = aws_instance.private-ec2s["private-1"].id
  port = 80
}

resource "aws_alb_target_group_attachment" "private-target-group-attachment2" {
  target_group_arn = var.private-tg-arn
  target_id = aws_instance.private-ec2s["private-2"].id
  port = 80
}