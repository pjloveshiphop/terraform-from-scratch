resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_nm
  }
}

resource "aws_subnet" "public" {
  count                   = length(var.azs)
  availability_zone       = var.azs[count.index]
  cidr_block              = var.public_sn_cidr_blocks[count.index]
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.vpc.id
  tags = {
    Name = var.public_sn_nms[count.index]
  }
}

resource "aws_subnet" "private" {
  count             = length(var.azs)
  availability_zone = var.azs[count.index]
  cidr_block        = var.private_sn_cidr_blocks[count.index]
  vpc_id            = aws_vpc.vpc.id
  tags = {
    Name = var.private_sn_nms[count.index]
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = join("-", [substr(aws_vpc.vpc.tags.Name, 0, length(aws_vpc.vpc.tags.Name) - 4), "igw"])
  }
}

# resource "aws_network_interface" "ngw_eni" {
#   subnet_id   = aws_subnet.public[0].id
#   description = "this eni is for eip of ngw"
#   tags = {
#     Name = join("-", [substr(aws_vpc.vpc.tags.Name, 0, length(aws_vpc.vpc.tags.Name) - 4), "ngw-eni"])
#   }
# }

resource "aws_eip" "ngw_eip" {
  vpc = true
  tags = {
    Name = join("-", [substr(aws_vpc.vpc.tags.Name, 0, length(aws_vpc.vpc.tags.Name) - 4), "ngw-eip"])
  }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id     = aws_eip.ngw_eip.id
  connectivity_type = "public"
  subnet_id         = aws_subnet.public[0].id
  tags = {
    Name = join("-", [substr(aws_vpc.vpc.tags.Name, 0, length(aws_vpc.vpc.tags.Name) - 4), "ngw"])
  }
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_network_acl" "nacl" {
  vpc_id     = aws_vpc.vpc.id
  subnet_ids = concat(aws_subnet.public[*].id, aws_subnet.private[*].id)
  ingress {
    from_port  = 0
    to_port    = 0
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    protocol   = "all"
  }
  egress {
    from_port  = 0
    to_port    = 0
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    protocol   = "all"
  }
  tags = {
    Name = join("-", [substr(aws_vpc.vpc.tags.Name, 0, length(aws_vpc.vpc.tags.Name) - 4), "nacl"])
  }
}

