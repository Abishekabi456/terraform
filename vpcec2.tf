provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "demo-server1" {
    ami = "ami-03f4878755434977f"
    instance_type = "t2.micro"
    key_name = "demo"
    vpc_security_group_ids = [aws_security_group.demo-sg.id]
    subnet_id = aws_subnet.demo_subnet.id
}
resource "aws_vpc" "demovpc" {
        cidr_block = "10.1.0.0/16"
   }
resource "aws_subnet" "demo_subnet" {
    vpc_id = aws_vpc.demovpc.id
    cidr_block = "10.1.1.0/24"
    tags = {
      Name = "demo_subent"
    }
}
resource "aws_internet_gateway" "demo-igw" {
    vpc_id = aws_vpc.demovpc.id
    tags = {
      Name = "demo-igw"
    }
}

resource "aws_route_table" "demo-rt" {
    vpc_id = aws_vpc.demovpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.demo-igw.id
    }
    tags = {
      Name = "demo-rt"
    }
}
resource "aws_route_table_association" "demo-rta" {
    subnet_id = aws_subnet.demo_subnet.id
    route_table_id = aws_route_table.demo-rt.id
}
resource "aws_security_group" "demo-sg" {
  name        = "demo-sg"
  vpc_id = aws_vpc.demovpc.id
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "demo-sg"
  }
}

