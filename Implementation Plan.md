<!-- Implementation Plan
Details
The following is in scope for the implementation plan:
1. An API to add Flybuys points to a customer’s account. The request will include the
customer’s Flybuys card number, which is what we’ll use to uniquely identify them.
2. An API for viewing customer’s Flybuys points balances.
The APIs will be used by multiple different companies.
Submission
Please write about the following:
1. APIs, including URL structure and params. You do not need to go into exact detail on the
response serialisation but do mention what would be returned.
2. Models: including attributes, validations, relationships.
3. Database indexes
4. Security and performance considerations.
5. Failure scenarios/handling.
6. Risks, or things that could go wrong.
7. Possible future scope or enhancement ideas. -->


# IP Answers:


1. API endpoints

Show Balances API:

```
cards#index
List of flybuys points balances
url: GET /cards/
params: nil
return: 
cards:[{
  card_number, 
  total_loaded_pts_in_cents,
  total_redemeed_pts_in_cents,
  customer: {customer_details},
  transactions: [{multiple_transaction_obj_with_companies}]
}]
```

```
cards#show
Show flybuy points with specific card number
url: GET /cards/:card_number
params: nil
return: card_number, total_loaded_pts_in_cents, total_redeemed_pts_in_cents, customer: {customer_details}, transactions: [{multiple_transaction_obj_with_companies}]
```


2. Pseudo Model and Relationship level in App

Cards
 - has_one Customer
 - has_many Transactions

Customer
 - has_many Cards
 - has_many Transactions

Transactions
 - has_many Cards
 - has_many Customer
 - has_many Companies

Companies
 - belongs_to Transactions


3. Database Indexes
  Transactions
  - card: card_number
  - owner: customer_id
  - business: company_id 

4. Security and Performance -
I think to we need to have some sort of API key and secret to control all of devices who will communicate with this API. ofcourse the more requests we will have, the expensive we spend on servers.

5. Failures scenarios/ handling -
I can't think of any yet. but this needs to be tested more.

6. Risks, or things that could go wrong -
since we didn't have any control on this API that was mentioned on 4. the possibly can go wrong is that we can have too many requests without knowing. and because that the server might stop working due to overload issues

7. Possible future scope or enhancement ideas -
Additional security on accessing the API, so we can scale how many requests should we spend on this.