# incentivemerchant  [![Code Climate](https://codeclimate.com/github/phongleland/incentivenetworks/badges/gpa.svg)](https://codeclimate.com/github/phongleland/incentivenetworks)

incentivemerchant is a RESTful API solution to get all transaction for a specific consumer and/or for a merchant.  There are three endpoints one for each model (consumer, merchant, transaction).  There is 100% test coverage

Install
--------

Download and run from your shell
```shell
bundle install
rake db:migrate
```

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
curl -d "consumer[firstname]=Phong" -d "consumer[lastname]=Le" warm-inlet-64646.herokuapp.com/consumers
```
To list all consumers
```shell
curl warm-inlet-64646.herokuapp.com/consumers
```
To get a specific consumer
```shell
curl warm-inlet-64646.herokuapp.com/consumers/1
```
To update a specific consumer
```shell
curl -XPATCH https://warm-inlet-64646.herokuapp.com/consumers/1  -d "consumer[lastname]=Doe"
```
To delete a specific consumer
```shell
curl -XDELETE warm-inlet-64646.herokuapp.com/consumers/1
```

To create a merchant
```shell
curl -d "merchant[name]=AMEX" -d "merchant[domain]=www.amex.com" warm-inlet-64646.herokuapp.com/merchants
```
To list all merchants
```shell
curl warm-inlet-64646.herokuapp.com/merchants
```
To get a specific merchant
```shell
curl warm-inlet-64646.herokuapp.com/merchants/1
```
To update a specific merchant
```shell
curl -XPATCH warm-inlet-64646.herokuapp.com/merchants/1  -d "merchant[name]=BofA"
```
To delete a specific merchant
```shell
curl -XDELETE warm-inlet-64646.herokuapp.com/merchants/1
```

To create a transaction you must use valid consumer and merchant ids
```shell
curl -d "transaction[sale_amount]=9.99" -d "transaction[sale_date]=2016-03-21" -d "transaction[consumer_id]=1" -d "transaction[merchant_id]=1" warm-inlet-64646.herokuapp.com/transactions
```
To list transactions (Search)
```shell
curl warm-inlet-64646.herokuapp.com/transactions?merchant_id=1
```
To get a specific transaction
```shell
curl warm-inlet-64646.herokuapp.com/transactions/1
```
To update a specific transaction
```shell
curl -XPATCH warm-inlet-64646.herokuapp.com/transactions/1  -d "transaction[sale_amount]=99.88"
```
To delete a specific merchant
```shell
curl -XDELETE warm-inlet-64646.herokuapp.com/transactions/1
```