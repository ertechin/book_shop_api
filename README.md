# Project Documentation

Welcome to the documentation for the Book Shop API project!

## Introduction

The Book Shop API is a RESTful web service that allows users to manage a virtual book shop.

## Getting Started

To get started with the Book Shop API, follow these steps:

1. Clone the repository: `git clone https://github.com/ertechin/book_shop_api.git`
2. Cd to project folder
### Without Docker
3. run ``bundle install``
4. Run `rails db:create && rails db:migrate && rails db:seed`
5. Configure the environment variables: ``export DEVISE_JWT_SECRET_KEY="shhitissecrett"``
5. Start the server: `rails s`
### With Docker
3. in app directory fund the ``example.env`` and copy what is in side and create file in the same directory name as ``.env`` and paste it.
4. change RAILS_MASTER_KEY
5. then run ``docker-compose build``
6. then run ``docker-compose up``
##### Everything should be fine, if not, try normal installation.
## Authentication

To access certain endpoints, authentication is required. You can obtain an access token by sending a POST request to the 

`http://localhost:3000/signup` or `http://0.0.0.0:3000/login`

endpoint with valid credentials. The access token should be included in the `Authorization` header of subsequent requests.

For  payment, basket, and user-data endpoints you must copy auth and paste it in side of hader named as `Authorization`

##### For postman clear cookies when sending request

## API Endpoints

##### you can find postman collection, in side of project named as book_shop_api_postman_collection, copy the json and import to postman.

##### After import, if there is a duplucated headers please uncheck them

<img src="https://i.hizliresim.com/blfcnvg.png" alt="After import, if there is a duplicated headers please uncheck them" width="300"/>\

####
example endpoint: ``http://0.0.0.0:3000/books``

The Book Shop API provides the following endpoints:

- `POST /signup`: Creates a new user.
  ####
  body will be:
  ####

    ```json
    {
      "user": {
        "email": "test2@test.com",
        "password": "password",
        "password_confirmation":"password"
      }
    }
    ```
  ####
  after succesful singup you  will see  ``"message": "Signed up successfully."``
  ####

- `POST /login`: Logs in a user.
  ####
  body will be:
  ####

    ```json
    {
      "user": {
          "email": "test2@test.com",
          "password": "password"
      }
    }
    ```
  ####
  after succesful login you  will see ``"message": "Logged in successfully."`` 
  ####
- `GET /books`: Retrieves a list of books.  ``` No need auth or body```
- `DEL /logout`: Logs out a user.  ``` No need body Authorization required```
- `GET /user_data`: Retrieves user data. ``` No need body Authorization required```
- `GET /get_basket`: Retrieves the user's basket. ``` No need body Authorization required```
- `POST /update_basket`: Updates the user's basket.
  ####
  body will be:
  ####

    ```json
      {
        "basket": {
            "data": {
                "item_id": "2",
                "quantity": "1"
            },
            "basket_action": "add_item"

            # basket actions are [add_item, remove_item, update_item_quantity]
            # You can do the necessary operations by changing the basket actions 
        }
      }
    ```
  ####
  after  succesfull operations you will  recive the basket
  ####

- `POST /clear_basket`: Clears the user's basket. ``` No need body Authorization required```
- `POST /create_payment`: Creates a payment. ``` No need body Authorization required```

## Run the tests
2. Cd to project folder
2. `rspec ./spec/baskets_controller_spec.rb`
3. `rspec ./spec/books_controller_spec.rb`



