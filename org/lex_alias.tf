resource "aws_lex_bot_alias" "sugus_bot_prod" {
  provider = aws.aws
  depends_on = [aws_lex_bot.sugus_bot]
  bot_name    = "SugusRecommender"
  bot_version = aws_lex_bot.sugus_bot.version
  description = "Bot para responder dudas acerca de los caramelos Sugus"
  name        = "SugusRecommenderProd"
}