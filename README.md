# AppSync Demo

This repo uses terraform with the [typicode Rest resources](https://jsonplaceholder.typicode.com/guide/)

## Setup

1. `terraform init`
2. `terraform plan`
3. `terraform apply`

## query

```graphql
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

Also users posts comments for 3-level deep (using caching)

```graphql
query MyQuery {
  users: getUsers {
    id,
    email,
    posts {
      id
      title,
      comments {
        id
        email
        body
      }
    }
  }
}
```

## Teardown / cleanup

`terraform destroy`
