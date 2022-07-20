resource "aws_lex_intent" "get_recommendation_intent" {
  provider = aws.aws
  confirmation_prompt {
    max_attempts = 2

    message {
      content      = "Queres que te recomiende un caramelo sugus?"
      content_type = "PlainText"
    }
  }

  name           = "GetRecommendation"
  description    = "Intent para pedir recomendacion de caramelos sugus"

  fulfillment_activity {
    type = "ReturnIntent"
  }

  rejection_statement {
    message {
      content      = "Ok, no te preocupes, podes pedirme una recomendacion cuando lo desees."
      content_type = "PlainText"
    }
  }

  sample_utterances = [
    "Quisiera conocer los caramelos disponibles",
    "Que caramelos hay?",
    "Que caramelos tienen?",
    "Recomendame caramelos",
    "Recomendame sugus",
    "Que sugus hay?",
    "Cual es el mejor sugus?",
    "Cual es el sugus mas rico?"
  ]
}

output "intents_arn" {
    value = aws_lex_intent.get_recommendation_intent.arn
}