resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "vpc"
  }
}

# Create a public subnet for each AZ in variables
resource "aws_subnet" "public" {
  for_each = var.public_subnet_numbers

  vpc_id            = aws_vpc.this.id
  availability_zone = each.key

  cidr_block = cidrsubnet(aws_vpc.this.cidr_block, 4, each.value)

  tags = {
    Name = format("public-subnet-%s", each.key)
  }
}

# Create application private subnet for each AZ in variables
resource "aws_subnet" "application" {
    for_each = var.private_subnet_numbers.application

  vpc_id                  = aws_vpc.this.id
  availability_zone       = each.key
  map_public_ip_on_launch = false

  cidr_block = cidrsubnet(aws_vpc.this.cidr_block, 4, each.value)

    tags = {
        Name = format("application-private-subnet-%s",each.key)
    }
}

# Create data private subnet for each AZ in variables
resource "aws_subnet" "data" {
    for_each = var.private_subnet_numbers.data

    vpc_id = aws_vpc.this.id
    availability_zone = each.key
    map_public_ip_on_launch = false

    cidr_block = cidrsubnet(aws_vpc.this.cidr_block, 4, each.value)

    tags = {
        Name = format("data-private-subnet-%s",each.key)
    }
}

# Route Tables for public subnets
resource "aws_route_table" "public" {
  for_each = aws_subnet.public
  vpc_id   = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = format("public-subnet-route-table-%s", each.key)
  }
}

# Route tables for private subnets
resource "aws_route_table" "application" {
    for_each = var.private_subnet_numbers.application
    vpc_id   = aws_vpc.this.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.this[each.key].id
    }

    tags = {
        Name = format("application-private-subnet-route-table-%s", each.value)
    }
}

resource "aws_route_table" "data" {
    for_each = var.private_subnet_numbers.data
    vpc_id   = aws_vpc.this.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.this[each.key].id
    }

    tags = {
        Name = format("data-private-subnet-route-table-%s", each.value)
    }
}

resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public[each.key].id
}

resource "aws_route_table_association" "application" {
    for_each = aws_subnet.application
    subnet_id = each.value.id
    route_table_id = aws_route_table.application[each.key].id
}

resource "aws_route_table_association" "data" {
    for_each = aws_subnet.data
    subnet_id = each.value.id
    route_table_id = aws_route_table.data[each.key].id
}

