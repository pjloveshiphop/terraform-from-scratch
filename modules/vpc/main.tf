resource "aws_vpc" "vpc" {
  for_each             = var.vpc_config
  cidr_block           = each.value.cidr_block
  instance_tenancy     = each.value.instance_tenancy
  enable_dns_support   = each.value.enable_dns_support
  enable_dns_hostnames = each.value.enable_dns_hostnames
  tags = {
    Name = each.key
  }
}

resource "aws_subnet" "public0" {
  for_each          = var.vpc_config
  vpc_id            = aws_vpc.vpc[each.key].id
  cidr_block        = each.value.public_cidr_blocks[0]
  availability_zone = each.value.azs[0]
  tags = {
    Name = each.value.public_sn_nms[0]
  }

}

resource "aws_subnet" "public1" {
  for_each          = var.vpc_config
  vpc_id            = aws_vpc.vpc[each.key].id
  cidr_block        = each.value.public_cidr_blocks[1]
  availability_zone = each.value.azs[1]
  tags = {
    Name = each.value.public_sn_nms[1]
  }

}

resource "aws_subnet" "public2" {
  for_each          = var.vpc_config
  vpc_id            = aws_vpc.vpc[each.key].id
  cidr_block        = each.value.public_cidr_blocks[2]
  availability_zone = each.value.azs[2]
  tags = {
    Name = each.value.public_sn_nms[2]
  }
}

resource "aws_subnet" "private0" {
  for_each          = var.vpc_config
  vpc_id            = aws_vpc.vpc[each.key].id
  cidr_block        = each.value.private_cidr_blocks[0]
  availability_zone = each.value.azs[0]
  tags = {
    Name = each.value.private_sn_nms[0]
  }
}

resource "aws_subnet" "private1" {
  for_each          = var.vpc_config
  vpc_id            = aws_vpc.vpc[each.key].id
  cidr_block        = each.value.private_cidr_blocks[1]
  availability_zone = each.value.azs[1]
  tags = {
    Name = each.value.private_sn_nms[1]
  }
}

resource "aws_subnet" "private2" {
  for_each          = var.vpc_config
  vpc_id            = aws_vpc.vpc[each.key].id
  cidr_block        = each.value.private_cidr_blocks[2]
  availability_zone = each.value.azs[2]
  tags = {
    Name = each.value.private_sn_nms[2]
  }
}

resource "aws_internet_gateway" "igw" {
  for_each = var.vpc_config
  vpc_id   = aws_vpc.vpc[each.key].id
  tags = {
    Name = each.value.igw_nm
  }
}

resource "aws_eip" "eip" {
  for_each = var.vpc_config
  tags = {
    Name = join("-", [each.value.ngw_nm, "eip"])
  }
}

resource "aws_nat_gateway" "ngw" {
  for_each          = var.vpc_config
  allocation_id     = aws_eip.eip[each.key].id
  connectivity_type = each.value.ngw_connectivity_type
  private_ip        = try(each.value.ngw_private_ip, null)
  subnet_id         = aws_subnet.public0[each.key].id
  tags = {
    Name = each.value.ngw_nm
  }
}

resource "aws_route_table" "public" {
  for_each = var.vpc_config
  vpc_id   = aws_vpc.vpc[each.key].id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw[each.key].id
  }
  tags = {
    Name = each.value.public_rtb_nm
  }
}

resource "aws_route_table_association" "public0" {
  for_each       = var.vpc_config
  subnet_id      = aws_subnet.public0[each.key].id
  route_table_id = aws_route_table.public[each.key].id
}

resource "aws_route_table_association" "public1" {
  for_each       = var.vpc_config
  subnet_id      = aws_subnet.public1[each.key].id
  route_table_id = aws_route_table.public[each.key].id
}

resource "aws_route_table_association" "public2" {
  for_each       = var.vpc_config
  subnet_id      = aws_subnet.public2[each.key].id
  route_table_id = aws_route_table.public[each.key].id
}

resource "aws_route_table" "private" {
  for_each = var.vpc_config
  vpc_id   = aws_vpc.vpc[each.key].id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw[each.key].id
  }
  tags = {
    Name = each.value.private_rtb_nm
  }
}

resource "aws_route_table_association" "private0" {
  for_each       = var.vpc_config
  subnet_id      = aws_subnet.private0[each.key].id
  route_table_id = aws_route_table.private[each.key].id
}

resource "aws_route_table_association" "private1" {
  for_each       = var.vpc_config
  subnet_id      = aws_subnet.private1[each.key].id
  route_table_id = aws_route_table.private[each.key].id
}

resource "aws_route_table_association" "private2" {
  for_each       = var.vpc_config
  subnet_id      = aws_subnet.private2[each.key].id
  route_table_id = aws_route_table.private[each.key].id
}

resource "aws_network_acl" "nacl" {
  for_each = var.vpc_config
  vpc_id   = aws_vpc.vpc[each.key].id
  subnet_ids = [
    aws_subnet.public0[each.key].id,
    aws_subnet.public1[each.key].id,
    aws_subnet.public2[each.key].id,
    aws_subnet.private0[each.key].id,
    aws_subnet.private1[each.key].id,
    aws_subnet.private2[each.key].id
  ]
  ingress {
    from_port  = 0
    to_port    = 0
    rule_no    = 100
    action     = "allow"
    protocol   = "all"
    cidr_block = "0.0.0.0/0"
  }
  egress {
    protocol   = "all"
    from_port  = 0
    to_port    = 0
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name = each.value.nacl_nm
  }

}
