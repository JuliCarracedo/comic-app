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

