
resource "aws_security_group" "sg" {
  for_each    = var.sg_config
  name        = each.key
  description = each.value.description
  vpc_id      = var.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffics"
  }
  tags = {
    Name = each.key
  }
}
