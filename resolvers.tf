resource "aws_appsync_resolver" "get_posts" {
  api_id          = aws_appsync_graphql_api.example.id
  type            = "Query"
  field           = "getPosts"
  data_source     = aws_appsync_datasource.jsonplaceholder.name
  request_template  = <<EOF
#set($userIdExists = !$util.isNullOrEmpty($context.arguments.userId))
{
  "version": "2018-05-29",
  "method": "GET",
  "resourcePath": "/posts",
  "params": {
    "headers": {},
    "query": {
      #if($userIdExists)
      "userId": "$context.arguments.userId",
      #end
    }
  }
}
EOF

  response_template = file("response_templates/passthrough_response.vtl")
}

resource "aws_appsync_resolver" "get_users" {
  api_id          = aws_appsync_graphql_api.example.id
  type            = "Query"
  field           = "getUsers"
  data_source     = aws_appsync_datasource.jsonplaceholder.name
  request_template  = <<EOF
{
  "version": "2018-05-29",
  "method": "GET",
  "resourcePath": "/users",
  "params": {
    "headers": {},
    "query": {}
  }
}
EOF

  response_template = file("response_templates/passthrough_response.vtl")
}

resource "aws_appsync_resolver" "get_comments" {
  api_id          = aws_appsync_graphql_api.example.id
  type            = "Query"
  field           = "getComments"
  data_source     = aws_appsync_datasource.jsonplaceholder.name
  request_template  = <<EOF
#set($postIdExists = !$util.isNullOrEmpty($context.arguments.postId))
#set($path = "/comments")

#if($postIdExists)
#set($path = "posts/$context.arguments.postId/$path")
#end

{
  "version": "2018-05-29",
  "method": "GET",
  "resourcePath": "$path",
  "params": {
    "headers": {},
    "query": {}
  }
}
EOF

  response_template = file("response_templates/passthrough_response.vtl")
}

resource "aws_appsync_resolver" "get_comments_for_post" {
  api_id          = aws_appsync_graphql_api.example.id
  type            = "Post"
  field           = "comments"
  data_source     = aws_appsync_datasource.jsonplaceholder.name
  request_template  = <<EOF
{
  "version": "2018-05-29",
  "method": "GET",
  "resourcePath": "/posts/$ctx.source.id/comments",
  "params": {
    "headers": {},
    "query": {}
  }
}
EOF

  response_template = file("response_templates/passthrough_response.vtl")
}

resource "aws_appsync_resolver" "get_user_posts" {
  api_id          = aws_appsync_graphql_api.example.id
  type            = "User"
  field           = "posts"
  data_source     = aws_appsync_datasource.jsonplaceholder.name
  request_template  = <<EOF
{
  "version": "2018-05-29",
  "method": "GET",
  "resourcePath": "/user/$ctx.source.id/posts",
  "params": {
    "headers": {},
    "query": {}
  }
}
EOF

  response_template = file("response_templates/passthrough_response.vtl")

  # Disable caching for this resolver
  caching_config {
    caching_keys = ["$context.source.id"]
    ttl          = 3600
  }
}