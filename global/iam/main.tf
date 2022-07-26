terraform {
  cloud {
    organization = "sjoss-info"

    workspaces {
      name = "sj-dev-apogee-testing"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  required_version = ">= 1.2.0"
}


resource "aws_iam_policy" "metrc-s3-policy" {
  name        = "s3-metrc-policy"
  description = "Allows access to Metrc reports stored in S3"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:*",
          "s3-object-lambda:*"
        ],
        "Resource" : [
          "arn:aws:s3:::apogee-gardens-dev/*",
          "arn:aws:s3:::apogee-gardens-dev/test-metrc-reports/*",
          "arn:aws:s3:::apogee-gardens-dev/metrc-reports-single-dates-only/*",
          "arn:aws:s3:::apogee-gardens-dev/athena-query-results/*",
          "arn:aws:s3:::apogee-gardens-prod/*",
          "arn:aws:s3:::apogee-gardens-prod/metrc-reports-thirty-day-window/*",
          "arn:aws:s3:::apogee-gardens-prod/metrc-reports-single-dates-only/*",
          "arn:aws:s3:::apogee-gardens-prod/athena-query-results/*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : "s3:GetBucketLocation",
        "Resource" : "arn:aws:s3:::*"
      }
    ]
  })
}

resource "aws_iam_policy" "metrc-athena-policy" {
  name        = "athena-lambda-metrc-webscraper-policy"
  description = "Gives Athena and Glue access"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "athena:*"
        ],
        "Resource" : [
          "arn:aws:athena:us-west-2:766154341964:workgroup/primary"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "glue:*"
        ],
        "Resource" : [
          "*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "metrc-secrets-manager-policy" {
  name        = "metrc-login-secret-policy"
  description = "Allows for the reading of Metrc Login Information"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "secretsmanager:GetResourcePolicy",
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecretVersionIds"
        ],
        "Resource" : [
          "arn:aws:secretsmanager:us-west-2:766154341964:secret:Metrc-Login-yy1ryt"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : "secretsmanager:ListSecrets",
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_policy" "powerbi-ec2-instance-policy" {
  name        = "powerbi-ec2-instance-polocy"
  description = "Allows for the configuration/interaction with ec2 instances running PowerBI and PowerBI Gateway"

  # TODO: We can be much more specific about which resources are references here
  # Might require a `depends_on` parameter
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource" : "arn:aws:logs:*:*:*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:Start*",
          "ec2:Stop*"
        ],
        "Resource" : "*"
      }
    ]
  })
}
