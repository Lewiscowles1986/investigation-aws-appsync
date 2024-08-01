# AppSync Demo

This repo uses terraform with the [typicode Rest resources](https://jsonplaceholder.typicode.com/guide/)

## Setup

1. `terraform init`
2. `terraform plan`
3. `terraform apply`

## query

```
query MyQuery {
  posts: getPosts {
    id
    title
    userId
    comments {
      id
      postId
      body
    }
  }
}
```

## Teardown / cleanup

`terraform destroy`
