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

   tags = {
      Name = "public-subnet-1"
   }
}

resource "aws_subnet" "public_2" {
   vpc_id = aws_vpc.main.id
   cidr_block = var.public_subnet_cidrs[1]
   availability_zone = var.availability_zones[1]

   tags = {
      Name = "public-vpc-2"
   }
}

resource "aws_subnet" "private_1" {
   vpc_id = aws_vpc.main.id
   cidr_block = var.private_subnet_cidrs[0]
   availability_zone = var.availability_zones[0]

   tags = {
      Name = "private-vpc-1"
   }
}

resource "aws_subnet" "private_2" {
   vpc_id = aws_vpc.main.id
   cidr_block = var.private_subnet_cidrs[1]
   availability_zone = var.availability_zones[1]

   tags = {
      Name = "private-vpc-2"
   }
}

resource "aws_internet_gateway" "igw" {
   vpc_id = aws_vpc.main.id

   tags = {
      Name = "main-igw"
   }
}

resource "aws_route_table" "public_route_table" {
   vpc_id = aws_vpc.main.id

   route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
   }

   tags = {
      Name = "route-table-main"
   }
}

resource "aws_route_table_association" "public_1" {
   subnet_id = aws_subnet.public_1.id
   route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_2" {
   subnet_id = aws_subnet.public_2.id
   route_table_id = aws_route_table.public_route_table.id
}

resource "aws_eip" "nat_eip" {
   doamin = "vpc"
}

resource "aws_nat_gateway" "ngw" {
   allocation_id = aws_eip.nat_eip.id
   subnet_id = aws_subnet.public_1.id

   tags = {
      Name = "main_ngw"
   }

   depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "private_route_table" {
   vpc_id = aws_vpc.main.id

   route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.ngw.id
   }

   tags = {
      Name = "private-route-table"
   }
}

resource "aws_route_table_association" "private_1" {
   subnet_id = aws_subnet.private_1.id
   route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_2" {
   subnet_id = aws_subnet.private_2.id
   route_table_id = aws_route_table.private_route_table.id
}