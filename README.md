# README

# Ruby version
  `3.2.0`
# Rails version
  `7.0.4.2 `
# Requirements
  `git`, `docker`, `docker-compose`

# How to setup

  `Clone`

  * $ git clone https://github.com/sidneypikot2/store_manager

  `Build docker containers`

  * $ docker compose build

  `Precompile assets`

  * $ docker compose run app bundle exec rake assets:precompile

  `Start docker containers`

  * $ docker compose up -d

  `Setup database`

  * $ docker compose exec app rake db:setup db:migrate

  `Populate db`

  * $ docker compose exec rake db:seed

  `Check logs`

  * $ docker compose exec app tail -f log/development.log

  `Stop docker container`

  # Sample Account
  ```
    email: test@gmail.com
    password: password
  ```

  # Routes
  ## Admin
  * Product CRUD
  ```
  http://localhost:3000/admin/products
  ```

  ## Customer Page
  * Product list, Cart system, Checkout system
  ```
  http://localhost:3000
  ```