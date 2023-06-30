resource "aws_key_pair" "key" {
  count      = length(var.key_config)
  key_name   = var.key_config[count.index].key_nm
  public_key = file(var.key_config[count.index].public_key_path)
  tags = {
    Name = var.key_config[count.index].key_nm
  }
}

resource "aws_instance" "ec2" {
  count                       = length(var.ec2_config)
  ami                         = var.ec2_config[count.index].ami
  associate_public_ip_address = var.ec2_config[count.index].associate_public_ip_address
  availability_zone           = var.ec2_config[count.index].az
  instance_type               = var.ec2_config[count.index].instance_type
  key_name                    = var.ec2_config[count.index].key_nm
  monitoring                  = var.ec2_config[count.index].monitoring
  root_block_device {
    delete_on_termination = var.ec2_config[count.index].root_block_device.delete_on_termination
    encrypted             = var.ec2_config[count.index].root_block_device.encrypted
    iops                  = var.ec2_config[count.index].root_block_device.iops != null ? var.ec2_config[count.index].root_block_device.iops : null
    volume_size           = var.ec2_config[count.index].root_block_device.volume_size
    volume_type           = var.ec2_config[count.index].root_block_device.volume_type
    tags = {
      Name = var.ec2_config[count.index].root_block_device.root_name
    }
  }
  vpc_security_group_ids = var.sg_id
  subnet_id              = var.sn_id
  tags = {
    Name = var.ec2_config[count.index].instance_name
  }
}

resource "aws_ebs_volume" "ebs" {
  count             = length(var.ebs_config) > 0 ? length(var.ebs_config) : 0
  availability_zone = var.ebs_config[count.index].az
  encrypted         = var.ebs_config[count.index].encrypted
  final_snapshot    = var.ebs_config[count.index].final_snapshot
  iops              = var.ebs_config[count.index].iops != null ? var.ebs_config[count.index].iops : null
  size              = var.ebs_config[count.index].size
  type              = var.ebs_config[count.index].type
  tags = {
    Name = var.ebs_config[count.index].vol_nm
  }
}

resource "aws_volume_attachment" "ebs_attc" {
  count       = length(var.ebs_config) > 0 ? length(var.ebs_config) : 0
  device_name = var.ebs_config[count.index].device_nm
  volume_id   = aws_ebs_volume.ebs[count.index].id
  instance_id = aws_instance.ec2[var.ebs_config[count.index].instance_id].id
}
