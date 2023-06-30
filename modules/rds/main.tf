resource "aws_db_subnet_group" "db_subnet_group" {
  name        = var.db_sg_config.name
  description = var.db_sg_config.description
  subnet_ids  = var.private_sn_ids
  tags = {
    Name = var.db_sg_config.name
  }
}

resource "aws_db_parameter_group" "db_param_group" {
  for_each    = var.db_pg_config
  name        = each.key
  family      = each.value.family
  description = each.value.description

  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = each.key
  }
}


resource "aws_db_instance" "db_instance" {
  count                       = length(var.db_instance_config) > 0 ? length(var.db_instance_config) : 0
  allocated_storage           = var.db_instance_config[count.index].allocated_storage
  allow_major_version_upgrade = var.db_instance_config[count.index].allow_major_version_upgrade
  apply_immediately           = var.db_instance_config[count.index].apply_immediately
  auto_minor_version_upgrade  = var.db_instance_config[count.index].auto_minor_version_upgrade
  backup_retention_period     = var.db_instance_config[count.index].backup_retention_period
  blue_green_update {
    enabled = var.db_instance_config[count.index].blue_green_update
  }
  db_name                               = var.db_instance_config[count.index].db_name != null || var.db_instance_config[count.index].db_name != "" ? var.db_instance_config[count.index].db_name : null
  db_subnet_group_name                  = aws_db_subnet_group.db_subnet_group.id
  deletion_protection                   = var.db_instance_config[count.index].deletion_protection
  enabled_cloudwatch_logs_exports       = var.db_instance_config[count.index].enabled_cloudwatch_logs_exports
  engine                                = var.db_instance_config[count.index].engine
  engine_version                        = var.db_instance_config[count.index].engine_version
  final_snapshot_identifier             = join("-", [var.db_instance_config[count.index].identifier, "final-snapshot"])
  identifier                            = var.db_instance_config[count.index].identifier
  instance_class                        = var.db_instance_config[count.index].instance_class
  multi_az                              = var.db_instance_config[count.index].multi_az
  parameter_group_name                  = aws_db_parameter_group.db_param_group[var.db_instance_config[count.index].parameter_group_name].id
  username                              = var.db_instance_config[count.index].username
  password                              = var.db_instance_config[count.index].password
  performance_insights_enabled          = var.db_instance_config[count.index].performance_insights_enabled
  performance_insights_retention_period = var.db_instance_config[count.index].performance_insights_retention_period
  port                                  = var.db_instance_config[count.index].port
  publicly_accessible                   = var.db_instance_config[count.index].publicly_accessible
  replica_mode                          = var.db_instance_config[count.index].replica_mode
  storage_encrypted                     = var.db_instance_config[count.index].storage_encrypted
  timezone                              = var.db_instance_config[count.index].timezone
  vpc_security_group_ids                = var.vpc_security_group_ids
  tags = {
    Name = var.db_instance_config[count.index].identifier
  }
}





