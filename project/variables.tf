variable "vpc-cidr" {

}

variable "subnets" {
  type = map(object({
    cidr_block = string
    availability_zone = string
  }))
}

variable "ec2-type" {
    description = "t2.micro"
    type = string
    
}

variable "public-subnet-ids" {
  type = map(string)
}

variable "all-traffic" {

}