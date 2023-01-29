output "ec2-ip" {
      value = aws_instance.aws_ubuntu.public_ip

}