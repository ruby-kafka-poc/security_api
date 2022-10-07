# README

Simple API to create users
It act as a producer to confluent Kafka

## Run

You will need postgres running (you have the docker-compose)

```shell
git clone git@github.com:ruby-kafka-poc/security_api.git
cd security_api

open https://confluent.cloud
# Create a free account (no credit card needed free for 1 month), create a cluster,
# create a global API key
# go to cluster, cluster overview, cluster settings and get the bootstrap server

# WARNING DO NOT COMMIT THIS THINGS ANYWHERE!!!
echo "
BOOTSTRAP_SERVERS=AAAAAAAAAA:9092
SECURITY_PROTOCOL=sasl_ssl
SASL_MECHANISM=PLAIN
SASL_USERNAME=BBBBBB
SASL_PASSWORD=CCCCCCC
" >> .priv_env
export $(cat ./.private_env | sed 's/#.*//g' | xargs )


bundle install
bundle update
bundle exec rake db:create db:migrate db:seed
```

## Routes

```shell
POST   /login
POST   /logout
POST   /users
PATCH  /users/:id
PUT    /users/:id
DELETE /users/:id
```

## Create some data

```shell
bundle exec rails server -b '0.0.0.0' -p 3004

curl --location -g --request POST 'http://localhost:3004/users' \
--header 'Content-Type: application/json' \
--data-raw '{ "user": {"password": "1234", "email": "someguy@gmail.com" }}'

curl --location -g --request POST 'http://localhost:3004/users' \
--header 'Content-Type: application/json' \
--data-raw '{ "user": {"password": "1234", "email": "john_do@gmail.com" }}'

curl --location -g --request POST 'http://localhost:3004/login' \
--header 'Content-Type: application/json' \
--data-raw '{ "password": "1234", "email": "someguy@gmail.com" }'

# jwt

```
