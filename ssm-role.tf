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

#create policy s3
resource "aws_iam_policy" "s3-ec2" {
  name_prefix = format("%s-s3-policy", var.customer)
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
  policy_arn = aws_iam_policy.s3-ec2.arn
  role       = aws_iam_role.ssm-s3-role.name
}

#Instance Profile ssm and s3 access
resource "aws_iam_instance_profile" "ssm-s3-profile" {
  name = format("%s-ssm-s3-profile", var.customer)
  role = aws_iam_role.ssm-s3-role.name
}
############################### FOR CODEDEPLOY ##########################################
#1.Attach Policy SSMCore
resource "aws_iam_role_policy_attachment" "ssmcore-attach-ssmcore" {
  role       = aws_iam_role.ssmcore-codedeploy-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

#2.Attach Policy CloudWatch
resource "aws_iam_role_policy_attachment" "ssmcore-attach-cwatch" {
  role       = aws_iam_role.ssmcore-codedeploy-role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

#3.Attach Policy codedeploy-ec2
resource "aws_iam_role_policy_attachment" "ssmcore-attach-codedeploy-ec2" {
  role       = aws_iam_role.ssmcore-codedeploy-role.name
  policy_arn = aws_iam_policy.codedeploy-service-as.arn
}
#Instance Profile
resource "aws_iam_instance_profile" "ssm-codedeploy-profile" {
  role = aws_iam_role.ssmcore-codedeploy-role.name
  name = format("%s-ssm-codedeploy-profile", var.project)
}

#Create Role for ec2 contain 1.ssminstancecore, 2.cwagent, 3.codedeploy policy
resource "aws_iam_role" "ssmcore-codedeploy-role" {
  name               = format("%s-ssmcore-codedeploy-role", var.project)
  assume_role_policy = file("template/assumepolicy.json")
  tags = merge(local.common_tags, {
    Name = format("%s-ssmcore-codedeploy-role", var.project)
  })
}