VPC: Crie uma VPC com o CIDR 10.0.0.0/16.

Multi-AZ: Use duas Availability Zones (ex: us-east-1a e us-east-1b).

Subnets:

2 Subnets Públicas (uma em cada AZ).

2 Subnets Privadas (uma em cada AZ).

variable "base_cidr_block" {
   description = "The base CIDR block for the VPC"
   type = string
   defaut = "10.0.0.0/16"
}

variable "availability_zone" {
   description = "A list of availability zones in which ro create subnets"
   type = list(string)
   default = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet"{
   
}