output "vpc_id" {
   value = aws_vpc.main.id
}

output "public_ec2_ip" {
   value = aws_instance.ec2_public_1.public_ip
}

output "private_ec2_id" {
   value = aws_instance.ec2_private_1.private_ip
}






