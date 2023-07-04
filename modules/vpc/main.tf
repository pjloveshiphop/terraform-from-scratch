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
    Name       = var.public_sn_nms[count.index]
    Identifier = "public"
  }
}

resource "aws_subnet" "private" {
  count             = length(var.azs)
  availability_zone = var.azs[count.index]
  cidr_block        = var.private_sn_cidr_blocks[count.index]
  vpc_id            = aws_vpc.vpc.id
  tags = {
    Name       = var.private_sn_nms[count.index]
    Identifier = "private"
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

resource "aws_eip" "eip" {
  count = length(var.eip_nms) > 0 ? length(var.eip_nms) : 0
  vpc   = true
  tags = {
    Name = var.eip_nms[count.index]
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

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = join("-", [substr(aws_vpc.vpc.tags.Name, 0, length(aws_vpc.vpc.tags.Name) - 4), "public-rtb"])
  }
}

locals {
  public_sn_ids = [
    aws_subnet.public[0].id,
    aws_subnet.public[1].id,
    aws_subnet.public[2].id
  ]
}

resource "aws_route_table_association" "public" {
  count          = length(local.public_sn_ids)
  route_table_id = aws_route_table.public.id
  subnet_id      = local.public_sn_ids[count.index]
}


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }
  tags = {
    Name = join("-", [substr(aws_vpc.vpc.tags.Name, 0, length(aws_vpc.vpc.tags.Name) - 4), "private-rtb"])
  }
}

locals {
  private_sn_ids = [
    aws_subnet.private[0].id,
    aws_subnet.private[1].id,
    aws_subnet.private[2].id
  ]
}

resource "aws_route_table_association" "private" {
  count          = length(local.private_sn_ids)
  route_table_id = aws_route_table.private.id
  subnet_id      = local.private_sn_ids[count.index]
}

resource "aws_customer_gateway" "cgw" {
  count      = length(var.cgw_config)
  bgp_asn    = 65000
  ip_address = var.cgw_config[count.index].ip_address
  type       = "ipsec.1"
  tags = {
    Name = var.cgw_config[count.index].name
  }
}

resource "aws_vpn_gateway" "vgw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = join("-", [substr(aws_vpc.vpc.tags.Name, 0, length(aws_vpc.vpc.tags.Name) - 4), "vgw"])
  }
}

resource "aws_security_group" "sg" {
  for_each    = var.sg_config
  name        = each.key
  description = each.value.description
  vpc_id      = aws_vpc.vpc.id
  egress {
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "all"
    description = "Allow all outbound traffic"
  }
  tags = {
    Name = each.key
  }
}

resource "aws_security_group_rule" "sg_rule" {
  for_each                 = var.sg_rule
  security_group_id        = aws_security_group.sg[each.value.sg_nm].id
  type                     = each.value.type
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  cidr_blocks              = length(each.value.cidr_blocks) != 0 ? each.value.cidr_blocks : null
  prefix_list_ids          = length(each.value.prefix_list_ids) != 0 ? each.value.prefix_list_ids : null
  self                     = each.value.cidr_blocks != null || each.value.source_security_group_id != null ? each.value.self : null
  source_security_group_id = each.value.source_security_group_id != "" ? each.value.source_security_group_id : null
  description              = each.value.description
}
