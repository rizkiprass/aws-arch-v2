data "aws_vpc_endpoint_service" "s3" {
  service_type = "Gateway"
  service      = "s3"
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = module.vpc.vpc_id
  service_name      = data.aws_vpc_endpoint_service.s3.service_name
  vpc_endpoint_type = "Gateway"

  tags = merge(local.common_tags, {
    Name = format("%s-%s-S3-endpoint", var.Customer, var.environment)
  })
}

resource "aws_vpc_endpoint_route_table_association" "private_s3_1" {
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
  route_table_id  = module.vpc.private_route_table_ids[0]
}

resource "aws_vpc_endpoint_route_table_association" "private_s3_1" {
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
  route_table_id  = module.vpc.private_route_table_ids[1]
}