#Create Role ssm core role
resource "aws_iam_role" "ssm-core-role" {
  name_prefix        = format("%s-ssm-core-role", var.customer)
  assume_role_policy = file("template/assumepolicy.json")
  tags = merge(local.common_tags, {
    Name = format("%s-ssm-core-role", var.customer)
  })

}

#Attach Policy SSMCore
resource "aws_iam_role_policy_attachment" "ssmcore-attach-ssmcore" {
  role       = aws_iam_role.ssm-core-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

#Attach Policy CloudWatch
resource "aws_iam_role_policy_attachment" "ssmcore-attach-cwatch" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  role       = aws_iam_role.ssm-core-role.name
}

#Instance Profile ssm
resource "aws_iam_instance_profile" "ssm-profile" {
  name = format("%s-ssm-profile", var.customer)
  role = aws_iam_role.ssm-core-role.name
}

##################################################################
#Create Role s3 role
resource "aws_iam_role" "ssm-s3-role" {
  name_prefix        = format("%s-ssm-s3-role", var.customer)
  assume_role_policy = file("template/assumepolicy.json")
  tags = merge(local.common_tags, {
    Name = format("%s-ssm-s3-role", var.customer)
  })
}

resource "aws_iam_policy" "s3-ec2" {
  name        = "test_policy"
  description = "policy for ec2 access s3 bucket"
  policy      = file("template/s3-ec2.json")
}

#Attach Policy SSMCore
resource "aws_iam_role_policy_attachment" "ssmcore-attach-ssmcore2" {
  role       = aws_iam_role.ssm-s3-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

#Attach Policy CloudWatch
resource "aws_iam_role_policy_attachment" "ssmcore-attach-cwatch2" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  role       = aws_iam_role.ssm-s3-role.name
}

#Attach Policy s3
resource "aws_iam_role_policy_attachment" "ssmcore-attach-s3" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  role       = aws_iam_role.ssm-s3-role.name
}

#Instance Profile ssm and s3 access
resource "aws_iam_instance_profile" "ssm-s3-profile" {
  name = format("%s-ssm-s3-profile", var.customer)
  role = aws_iam_role.ssm-s3-role.name
}