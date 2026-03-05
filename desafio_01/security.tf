resource "aws_security_group" "sg_web" {
   name ="sg_main"
   description = "Security group for main VPC"
   vpc_id = aws_vpc.main.id
}

resource "aws_vpc_security_group_ingress_rule" "sg_web_ingress" {
   security_group_id = aws_security_group.sg_web.id

   cidr_ipv4 = "0.0.0.0/0"
   from_port = 80
   to_port = 80
   ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "sg_web_ingress_access" {
   security_group_id = aws_security_group.sg_web.id

   cidr_ipv4 = "0.0.0.0/0"
   from_port = 22
   to_port = 22
   ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "sg_web_egress" {
   security_group_id = aws_security_group.sg_web.id
   cidr_ipv4 = "0.0.0.0/0"

   ip_protocol = "-1"
}

resource "aws_security_group" "sg_bd" {
   name ="sg_bd"
   description = "Security group for main VPC"
   vpc_id = aws_vpc.main.id
}

resource "aws_vpc_security_group_ingress_rule" "sg_bd_ingress" {
   security_group_id = aws_security_group.sg_bd.id
   from_port = 5432
   to_port = 5432
   ip_protocol = "tcp"
   referenced_security_group_id = aws_security_group.sg_web.id 
}

resource "aws_vpc_security_group_ingress_rule" "sg_bd_ingress_access" {
   security_group_id = aws_security_group.sg_bd.id
   from_port = 22
   to_port = 22
   ip_protocol = "tcp"
   referenced_security_group_id = aws_security_group.sg_web.id 
}

resource "aws_vpc_security_group_egress_rule" "sg_db_egress" {
   security_group_id = aws_security_group.sg_web.id
   cidr_ipv4 = "0.0.0.0/0"

   ip_protocol = "-1"
}