terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

# Створює основну VPC із заданим CIDR-блоком.
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "KOWO"
  }
}

# Створює Інтернет-шлюз (Internet Gateway) і підключає його до основної VPC.
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Internet Gateway"
  }
}

 # Створює 1 публічну підмережу (Public Subnets) в 1й зоні доступності. 
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "Public subnet"
  }
}


# Створює 1 приватну підмережу (Private Subnets) в 1й зоні доступності.
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-central-1b"

  tags = {
    Name = "Private subnet"
  }
}

# Створює таблицю маршрутизації для публічних підмереж.
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Public route table"
  }
}

# Додає маршрут у таблицю маршрутизації, щоб спрямувати весь трафік в Інтернет.
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

# Прив'язує публічні підмережі до публічної таблиці маршрутизації.
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}


# Створює таблицю маршрутизації для приватних підмереж.
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Private route table"
  }
}


 # Прив'язує приватні підмережі до приватної таблиці маршрутизації.
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
