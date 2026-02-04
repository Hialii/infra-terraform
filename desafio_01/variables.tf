variable "base_cidr_block" {
   description = "The base CIDR block for the VPC"
   type = string
   default = "10.0.0.0/16"
}

variable "availability_zones" {
   description = "A list of availability zones in which ro create subnets"
   type = list(string)
   default = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidrs" {
   description = "A list of CIDR blocks for the public subnets"
   type = list(string)
   default = ["10.0.1.0/16", "10.0.2.0/16"]
}

variable "private_subnet_cidrs" {
   description = "Alist of CIDR blocks for the private subnets"
   type = list(string)
   default = ["10.0.3.0/16", "10.0.4.0/16"]
}