resource "aws_vpc" "stage_vpc" {
  cidr_block = "172.16.0.0/16"
  tags = {
    Name = "stage_vpc"
  }
}

resource "aws_subnet" "stage_vpc_public1" {
  vpc_id            = aws_vpc.stage_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "ap-northeast-2a"
  tags = {
    Name = "stage_vpc_public1"
  }
}

resource "aws_network_interface" "private_interface" {
  subnet_id   = aws_subnet.stage_vpc_public1.id
  private_ips = ["172.16.10.100"]
  tags = {
    Name = "private_interface"
  }
}

resource "aws_instance" "stage_bastion" {
  ami           = "ami-0c76973fbe0ee100c"
  instance_type = "t2.micro"
  network_interface {
    network_interface_id = aws_network_interface.private_interface.id
    device_index         = 0
  }
  credit_specification {
    cpu_credits = "unlimited"
  }
}