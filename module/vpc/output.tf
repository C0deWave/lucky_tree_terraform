output "vpc_name" {
  value = var.vpc_name
}

output "vpc_id" {
  value = aws_vpc.module_vpc.id
}

output "subnet_ability_zone" {
  value = [
    data.aws_availability_zones.available.names[0],
    data.aws_availability_zones.available.names[1]
  ]
}

output "public_subnet_id" {
  value = [
    aws_subnet.module_vpc_subnet_public1.id,
    aws_subnet.module_vpc_subnet_public2.id
  ]
}

output "private_subnet_id" {
  value = [
    aws_subnet.module_vpc_subnet_private1.id,
    aws_subnet.module_vpc_subnet_private2.id,
  ]
}

output "public_subnet_name" {
  value = [
    aws_subnet.module_vpc_subnet_public1.tags.Name,
    aws_subnet.module_vpc_subnet_public2.tags.Name
  ]
}

output "private_subnet_name" {
  value = [
    aws_subnet.module_vpc_subnet_private1.tags.Name,
    aws_subnet.module_vpc_subnet_private2.tags.Name,
  ]
}

output "internet_gateway_id" {
  value = aws_internet_gateway.module_vpc_ig.id
}