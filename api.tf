resource "aws_appsync_graphql_api" "example" {
  name                = "example"
  authentication_type = "API_KEY"

  schema = file("schema.graphql")

  log_config {
    field_log_level = "ALL"  # Set the level of logging. Options are NONE, ERROR, ALL.
    cloudwatch_logs_role_arn = aws_iam_role.appsync_logging_role.arn
  }

  xray_enabled = true
}

resource "aws_appsync_api_key" "example" {
  api_id = aws_appsync_graphql_api.example.id
}
