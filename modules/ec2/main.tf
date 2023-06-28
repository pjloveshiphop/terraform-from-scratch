resource "aws_key_pair" "key" {
  count      = length(var.key_config)
  key_name   = var.key_config[count.index].key_nm
  public_key = file(var.key_config[count.index].public_key_path)
  tags = {
    Name = var.key_config[count.index].key_nm
  }
}
