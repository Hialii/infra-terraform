output "vpc_id" {
   value = aws_vpc.main.id
}

output "sybnet_ids" {
   value = aws_subnet.main.*.id
}

