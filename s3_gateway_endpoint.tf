resource "aws_vpc_endpoint" "s3" {
  vpc_id            = ""
  service_name      = "com.amazonaws.ap-northeast-1.s3"
  route_table_ids   = [var.route_table_app_endpoint_id]
  vpc_endpoint_type = "Gateway"

  policy = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "*",
      "Effect": "Allow",
      "Resource": "*",
      "Principal": "*"
    }
  ]
}
POLICY

  tags = {
    Name = "app-vpce-s3"
  }
}