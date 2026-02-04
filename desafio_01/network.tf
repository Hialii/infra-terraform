resource "aws_vpc" "main" {
  cidr_block = var.base_cidr_block

  tags = {
   Name = "vpc-main"
  }
}

resource "aws_subnet" "public_1" {
   vpc_id = aws_vpc.main.id
   cidr_block = var.public_subnet_cidrs[0]
   availability_zone = var.availability_zones[0]

   tas = {
      Name = "public-subnet-1"
   }
}

resourse "aws_subnet" "public_2" {
   vpc_id = aws_vpc.main.id
   cidr_block = var.public_subnet_cidrs[1]
   availability_zone = var.availability_zones[1]

   tags = {
      Name = "public-vpc-2"
   }
}

resourse "aws_subnet" "private_1" {
   vpc_id = aws_vpc.main.id
   cidr_block = var.private_subnet_cidrs[0]
   availability_zone = var.availability_zones[0]

   tags = {
      Name = "private-vpc-1"
   }
}

resourse "aws_subnet" "private_2" {
   vpc_id = aws_vpc.main.id
   cidr_block = var.private_subnet_cidrs[1]
   availability_zone = var.availability_zones[1]

   tags = {
      Name = "private-vpc-2"
   }
}