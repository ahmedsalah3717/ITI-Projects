variable "ami-id" {
    description = "amazon linux machine id"
    type = string
    default = "ami-0b5eea76982371e91"

  
}

variable "instance_type" {
    default = "t2.micro"
  
}

variable "VPC-cidr" {
  description = "cidr block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public-subnet-cidr" {
  description = "cidr block for public subnet"
  type        = string
  default     = "10.0.0.0/24"
}


variable "private-subnet-cidr" {
  description = "cidr block for private subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "az-public" {
    type = string
    default = "us-east-1a"
  
}

variable "az-private" {
    type = string
    default = "us-east-1b"
  
}

variable "public-subnets-count" {
    type = number
    default = 1
  
}

variable "private-subnets-count" {
    type = number
    default = 1
  
}