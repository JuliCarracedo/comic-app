# COMIC-APP API DOCUMENTATION

> The base URL is: https://cherry-crumble-58684.herokuapp.com/api/

## User Login and Registration

### Registration

- Endpoint: GET `/users/sign_up`
- Auth Token: Not required
- Body required:

```
{
    "email": "example@example.com",
    "password" : "12345678",
    "username" : "John Doe"
}
```
If the request is successfull, you'll receive a success message, an auth token and a copy of the user object.
Otherwise you will receive a standard RoR 'errors' object.

### Login

- Endpoint: POST `/users/login`
- Auth Token: Not Required
- Body required:

```
{
    "email": "example@example.com",
    "password" : "12345678",
}
```
If the request is successfull, you'll receive a success message, an auth token and a copy of the user object.
Otherwise you will receive a standard RoR 'errors' object.

## Comics

### Create a comic

- Endpoint: POST `/comics`
- Auth Token: Required
- Body required: 
```
{
    "title": "John Doe's great adventure",
    "description" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras orci risus, euismod sit amet augue nec, pellentesque imperdiet augue. Nam.",
}
```

This endpoint will either create the new comic and return a copy of it upon successs or it will return a standard `errors` object explaining what went wrong.

### Show a comic

- Endpoint: GET `/comics/:id`
- Auth Token: Required
- Body required: None

This endpoint will return a copy of the comic with the indicated ID unless there isn't one that matches.