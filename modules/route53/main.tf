# resource "aws_route53_zone" "zone" {
#   count         = length(var.route53_config) > 0 ? length(var.route53_config) : 0
#   name          = var.route53_config[count.index].host_zone_nm
#   comment       = var.route53_config[count.index].host_zone_comment
#   force_destroy = var.route53_config[count.index].force_destroy
#   tags = {
#     Name = var.route53_config[count.index].host_zone_nm
#   }
# }

# resource "aws_route53_record" "record" {

# }