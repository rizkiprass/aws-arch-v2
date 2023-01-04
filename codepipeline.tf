## DEVELOPMENT ##############################################################################################
#############################################################################################################

data "aws_iam_policy_document" "assume_by_sandbox" {
  statement {
    sid     = "AllowAssumeByPipeline"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "sandbox-pipeline-service-role" {
  name               = "sandbox-pipeline-service-role"
  assume_role_policy = data.aws_iam_policy_document.assume_by_sandbox.json
}

data "aws_iam_policy_document" "sandbox-pipeline" {
  statement {
    sid    = "AllowS3"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AllowECR"
    effect = "Allow"

    actions   = ["ecr:DescribeImages"]
    resources = ["*"]
  }

  statement {
    sid    = "AllowCodebuild"
    effect = "Allow"

    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowCodedepoloy"
    effect = "Allow"

    actions = [
      "codedeploy:CreateDeployment",
      "codedeploy:GetApplication",
      "codedeploy:GetApplicationRevision",
      "codedeploy:GetDeployment",
      "codedeploy:GetDeploymentConfig",
      "codedeploy:RegisterApplicationRevision"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowResources"
    effect = "Allow"

    actions = [
      "elasticbeanstalk:*",
      "ec2:*",
      "codecommit:*",
      "elasticloadbalancing:*",
      "autoscaling:*",
      "cloudwatch:*",
      "s3:*",
      "sns:*",
      "cloudformation:*",
      "rds:*",
      "sqs:*",
      "ecs:*",
      "opsworks:*",
      "devicefarm:*",
      "servicecatalog:*",
      "iam:PassRole",
      "iam:*"
    ]
    resources = ["*"]
  }
}

resource "aws_sns_topic" "sandbox-sns" {
  name = "sandbox-sns"
}
resource "aws_iam_role_policy" "sandbox-pipeline" {
  role   = aws_iam_role.sandbox-pipeline-service-role.name
  policy = data.aws_iam_policy_document.sandbox-pipeline.json
}

# Create pipeline
resource "aws_codepipeline" "this-sandbox-pipeline" {
  name     = "sandbox-pipeline"
  role_arn = aws_iam_role.sandbox-pipeline-service-role.arn

  artifact_store {
    location = aws_s3_bucket.sandbox-artifact.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["SourceArtifact"]

      configuration = {
        RepositoryName = aws_codecommit_repository.sandbox-cicd.repository_name
        BranchName     = "main"
      }
    }

  }

  stage {
    name = "Deploy"

    action {
      name            = "DeployToAutoSaling"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      input_artifacts = ["SourceArtifact"]
      version         = "1"
      configuration = {
        ApplicationName     = aws_codedeploy_app.sandbox-deploy.name
        DeploymentGroupName = aws_codedeploy_deployment_group.sandbox-deployment.deployment_group_name
      }
    }
  }
}
