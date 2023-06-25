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
  cidr_block        = each.value.cidr_blocks[0]
  availability_zone = each.value.azs[0]
  tags = {
    Name = each.value.public_sn_nms[0]
  }

}

resource "aws_subnet" "public1" {
  for_each          = var.vpc_config
  vpc_id            = aws_vpc.vpc[each.key].id
  cidr_block        = each.value.cidr_blocks[1]
  availability_zone = each.value.azs[1]
  tags = {
    Name = each.value.public_sn_nms[1]
  }

}

resource "aws_subnet" "public2" {
  for_each          = var.vpc_config
  vpc_id            = aws_vpc.vpc[each.key].id
  cidr_block        = each.value.cidr_blocks[2]
  availability_zone = each.value.azs[2]
  tags = {
    Name = each.value.public_sn_nms[2]
  }

}
