resource "aws_appsync_datasource" "jsonplaceholder" {
  api_id = aws_appsync_graphql_api.example.id
  name   = "Posts"

  type = "HTTP"

  http_config {
    endpoint = "https://jsonplaceholder.typicode.com/"
  }
}
