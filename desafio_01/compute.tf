data aws_ami "unbutu" {
   most_recent = true

   filter {
      name = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]

      owners = ["099720109477"] # Canonical
   }
}

resource "aws_instance" "ec2_public_1" {
   ami = data.aws_ami.unbutu.id
   instance_type = var.instance_type
   subnet_id = aws_subnet.public_1.id
   vpc_security_group_ids = [aws_security_group.sg_web.id]
      tags = {
       Name = "ec2_public_1" 
   }
} 

resource "aws_instance" "ec2_private_1" {
   ami = data.aws_ami.unbutu.id
   instance_type = var.instance_type
   subnet_id = aws_subnet.private_1.id
   vpc_security_group_ids = [aws_security_group.sg_bd.id]
   tags = {
       Name = "ec2_private_1" 
   }
}