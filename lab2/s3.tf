
resource "aws_instance" "aws_ubuntu" {
  ami                         = var.ami-id
  instance_type               = var.instance_type
  key_name                    = "lab-1-terra"
  associate_public_ip_address = "true"
  subnet_id                   = aws_subnet.subnet-1.id
  vpc_security_group_ids      = [aws_security_group.demo_sg.id]
  security_groups             = [aws_security_group.demo_sg.id]
  user_data                   = file("init.sh")
}

resource "aws_instance" "private_instance" {
  ami                         = var.ami-id
  instance_type               = var.instance_type
  key_name                    = "lab-1-terra"
  subnet_id                   = aws_subnet.subnet-2.id
  # vpc_security_group_ids      = [aws_security_group.demo_sg.id]
  # security_groups             = [aws_security_group.demo_sg.id]
  user_data                   = file("init.sh")
}
  
