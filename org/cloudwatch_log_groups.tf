resource "aws_cloudwatch_log_group" "lex_logs" {
    provider = aws.aws
    name = "lex_logs"

    /*tags = {
    Environment = "production"
    Application = "serviceA"
    }*/
}