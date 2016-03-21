# incentivemerchant  [![Code Climate](https://codeclimate.com/github/phongleland/incentivenetworks/badges/gpa.svg)](https://codeclimate.com/github/phongleland/incentivenetworks)

incentivemerchant is a RESTful API solution to get all transaction for a specific consumer and/or for a merchant.  There are three endpoints one for each model (consumer, merchant, transaction).  There is 100% test coverage

Install
--------

Download and run `rake db:migrate` from your shell.

To run tests
```shell
rake db:test:install
bundle exec rspec
```

To seed the database
```shell
rake db:seed
```

To start the server
```shell
rails s
```

Usage
--------

To create a consumer
```shell
curl -d "consumer[firstname]=Phong" -d "consumer[lastname]=Le" localhost:3000/consumers
```
To list all consumers
```shell
curl localhost:3000/consumers
```
To get a specific consumer
```shell
curl localhost:3000/consumers/1
```
To update a specific consumer
```shell
curl -XPATCH localhost:3000/consumers/1  -d "consumer[lastname]=Doe"
```
To delete a specific consumer
```shell
curl -XDELETE localhost:3000/consumers/1
```

To create a merchant
```shell
curl -d "merchant[name]=AMEX" -d "merchant[domain]=www.amex.com" localhost:3000/merchants
```
To list all merchants
```shell
curl localhost:3000/merchants
```
To get a specific merchant
```shell
curl localhost:3000/merchants/1
```
To update a specific merchant
```shell
curl -XPATCH localhost:3000/merchants/1  -d "merchant[name]=BofA"
```
To delete a specific merchant
```shell
curl -XDELETE localhost:3000/merchants/1
```

To create a transaction you must use valid consumer and merchant ids
```shell
curl -d "transaction[sale_amount]=9.99" -d "transaction[sale_date]=2016-03-21" -d "transaction[consumer_id]=1" -d "transaction[merchant_id]=1" localhost:3000/transactions
```
To list transactions (Search)
```shell
curl localhost:3000/transactions?merchant_id=1
```
To get a specific transaction
```shell
curl localhost:3000/transactions/1
```
To update a specific transaction
```shell
curl -XPATCH localhost:3000/transactions/1  -d "transaction[sale_amount]=99.88"
```
To delete a specific merchant
```shell
curl -XDELETE localhost:3000/transactions/1
```