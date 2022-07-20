/*data "aws_iam_policy_document" "lex_assume_role_policy" {
  provider = aws.aws
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lex.amazonaws.com"]
    }
    resources = ["${aws_lex_bot.sugus_bot.arn}"]
  }
}

resource "aws_iam_role" "aws_service_role_for_lex_bots" {
  provider = aws.aws
  assume_role_policy = data.aws_iam_policy_document.lex_assume_role_policy.json
  name               = "AWSServiceRoleForLexBots"
  path               = "/aws-service-role/lex.amazonaws.com/"
}*/