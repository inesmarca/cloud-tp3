
resource "aws_lex_bot" "sugus_bot" {
    depends_on = [aws_lex_intent.get_recommendation_intent]
    provider = aws.aws
    enable_model_improvements = true
    
    abort_statement {
        message {
            content      = "Perdon, en este momento no le puedo asistir."
            content_type = "PlainText"
        }
    }

    child_directed = false

    clarification_prompt {
        max_attempts = 2

        message {
            content      = "No entendí, que desea hacer?"
            content_type = "PlainText"
        }
    }

    create_version              = false
    description                 = "Bot para responder dudas acerca de los caramelos Sugus"
    idle_session_ttl_in_seconds = 600

    intent {
        intent_name    = "GetRecommendation"
        intent_version = "$LATEST"
    }
    /*intent {
        intent_name    = "AskHistory"
        intent_version = "1"
    }*/

    locale           = "es-419"
    name             = "SugusRecommender"
    process_behavior = "BUILD"
}

output "bot_arn" {
    value = aws_lex_bot.sugus_bot.arn
}