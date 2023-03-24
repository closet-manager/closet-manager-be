# :shirt:Closet Manager:womans_clothes:

This application exposes backend endpoints for our frontend application to consume. Working in a service-oriented architecture the frontend will communicate with this application through an API in order to build an application that allows users to create clothing items, personalized packing lists, favorite clothing items, and sort clothing items by different parameters.

This project follows guidelines set in place by Turing School of Software & Design. For more information on project requirements: [Capstone Project](https://mod4.turing.edu/projects/capstone/)

[![forthebadge](http://forthebadge.com/images/badges/made-with-ruby.svg)](http://forthebadge.com)

## :computer:Technologies
- Rails 5.2.8
- Ruby 2.7.4
- Gems:gem::
  - faraday | jsonapi-serializer | dotenv-rails | factory_bot_rails | faker | webmock | vcr | shoulda-matchers | simplecov | rspec-rails
- Postman
- AWS S3
- AWS deployment

## :heavy_check_mark:Installation
1. Fork and clone this repository
2. `cd` into the root directiory
3. `bundle install`
4. `rails db:{drop,create,migrate}`
5. Run the test suite with `bundle exec rspec`
6. Start the local server by running `rails s`
7. Visit the app on `localhost:3000` in your web browser

## :round_pushpin:Endpoints

<details close>

### Get a User


```http
GET /api/v1/user/:id
```

<details close>
<summary>  Details </summary><br>
  * This endpoint returns a user
<br><br>
    
Parameters: <br>
```
None
```

| Code | Description |
| :--- | :--- |
| 200 | `OK` |

Example Value:

```json

{
    "user": {
              "first_name": "Rachel",
              "last_name": "Green",
              "email": "test@example.com"
           }
}

```

</details>

---

### Get a User's Items
```http
GET "/api/v1/users/:id/items"
```

<details close>
<summary>  Details </summary><br>
  * This endpoint returns all of a user's clothing items
<br><br>
    
Parameters: <br>
```
None
```

| Code | Description |
| :--- | :--- |
| 200 | `OK` |

Example Value:

```json

{
    hash goes here
}
```

</details>

---

### Get One Item from a User
```http
GET "/api/v1/users/:id/items/:id"
```

<details close>
<summary>  Details </summary><br>
  * This endpoint returns one specific clothing item from a user
<br><br>
    
Parameters: <br>
```
None
```

| Code | Description |
| :--- | :--- |
| 200 | `OK` |

Example Value:

```json

{
    hash goes here
}
```

</details>

---

### Get One Item from a User based off a category
```http
GET "/api/v1/users/:id/items/find_all?category=#{category}"
```

<details close>
<summary>  Details </summary><br>
  * This endpoint returns one specific clothing item from a user based off a specified category
<br><br>
    
Parameters: <br>
```
Category
```

| Code | Description |
| :--- | :--- |
| 200 | `OK` |

Example Value:

```json

{
    hash goes here
}
```

</details>

---

### Create an Item
```http
POST "/api/v1/users/:id/items"
```

<details close>
<summary>  Details </summary><br>
  * This endpoint creates a user's item
<br><br>
    
Parameters: <br>
```
CONTENT_TYPE=application/json
```

| Code | Description |
| :--- | :--- |
| 201 | `CREATED` |

Example Value:

```json

{
    "success": "Item was successfully created"
}
```

</details>

---

### Delete a User's Item

```http
DELETE /api/v1/users/:id/items/:id
```

<details close>
<summary>  Details </summary>
  * This endpoint deletes a user's item
<br><br>
    
Parameters: <br>
```
CONTENT_TYPE=application/json
```

| Code | Description |
| :--- | :--- |
| 204 | No Content |

Example Value:

```json
""
```

</details>

---

### Get a User's Lists
```http
GET /api/v1/users/:id/lists/:id
```


<details close>
<summary>  Details </summary><br>
  * This endpoint returns all of a user's lists
<br><br>
    
Parameters: <br>
```
None
```

| Code | Description |
| :--- | :--- |
| 200 | `OK` |

Example Value:

```json

{
    hash goes here
}
```

</details>

---

### Get one List from a User
```http
GET "/api/v1/users/:id/lists/:id"
```

<details close>
<summary>  Details </summary><br>
  * This endpoint returns a user's specific list
<br><br>
    
Parameters: <br>
```

```

| Code | Description |
| :--- | :--- |
| 201 | `CREATED` |

Example Value:

```json

{
    hash goes here
}
```

</details>

---

### Create a List
```http
POST "/api/v1/users/:id/lists"
```

<details close>
<summary>  Details </summary><br>
  * This endpoint creates a user's list
<br><br>
    
Parameters: <br>
```
CONTENT_TYPE=application/json
```

| Code | Description |
| :--- | :--- |
| 201 | `CREATED` |

Example Value:

```json

{
    "success": "List was successfully created"
}
```

</details>

---

### Delete a List

```http
DELETE /api/v1/users/:id/items/:id
```

<details close>
<summary>  Details </summary>
  * This endpoint deletes a user's specific list
<br><br>
    
Parameters: <br>
```
CONTENT_TYPE=application/json
```

| Code | Description |
| :--- | :--- |
| 204 | No Content |

Example Value:

```json
""
```

</details>

---

### Create an List's Item
```http
POST "/api/v1/users/:id/list_items"
```

<details close>
<summary>  Details </summary><br>
  * This endpoint creates a an item for a user's list
<br><br>
    
Parameters: <br>
```
CONTENT_TYPE=application/json
```

| Code | Description |
| :--- | :--- |
| 201 | `CREATED` |

Example Value:

```json

{
    "success": "List item was successfully created"
}
```

</details>

--- 

### Delete a List Item

```http
DELETE /api/v1/users/:id/list_items/:id
```

<details close>
<summary>  Details </summary>
  * This endpoint deletes a item from a user's list
<br><br>
    
Parameters: <br>
```
CONTENT_TYPE=application/json
```

| Code | Description |
| :--- | :--- |
| 204 | No Content |

Example Value:

```json
""
```

</details>
</details>

## :twisted_rightwards_arrows:Database Schema
