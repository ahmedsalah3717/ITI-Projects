resource "aws_s3_bucket" "bucket-2" {
  bucket = "lab-1-terraform-2nd"

}

resource "aws_instance" "aws_ubuntu" {
  ami                         = "ami-0b5eea76982371e91"
  instance_type               = "t2.micro"
  key_name                    = "lab-1-terra"
  associate_public_ip_address = "true"
  subnet_id                   = aws_subnet.subnet-1.id
  vpc_security_group_ids      = [aws_security_group.demo_sg.id]
  security_groups             = [aws_security_group.demo_sg.id]
  user_data                   = file("init.sh")
  depends_on = [
    aws_s3_bucket.bucket-2

  ]

}