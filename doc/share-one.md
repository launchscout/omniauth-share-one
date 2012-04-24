Following the Authorization Code flow at http://www.getharvest.com/api/authentication-oauth2, the major differences in our implementation are as follows:

1. state is not required for any requests
2. we aren't using client_secret.  Instead, we will be using IP addresses to limit API access.

Given the above, a typical end-to-end would look like this:

Authorization request
---------------------

  GET https://emery-md.nssecurebanking.org/oauth/authorize?client_id=xxxxxxxxx&redirect_url=https://www.budgetsketch.com

..member interacts with Online Banking...

Member approval/redirect
------------------------

(This will be whatever url was passed to redirect_url above, with the additional querystring arguments appended)

  REDIRECT https://www.budgetsketch.com?response_type=code&code=yyyyyyyyyy

BudgetSketch request for access token
-------------------------------------

Request:

  POST https:/emery-md.nssecurebanking.org/oauth/token

  Params:

    client_id=xxxxxxxxx
    code=yyyyyyyyyy
    grant_type=authorization_code

Response(JSON):

  {
    “token_type”: “bearer”,
    “expires_in”: 3600,
    “access_token”: “zzzzzzzzzzz”,
    “refresh_token”: “rrrrrrrrrr”
  }

Requesting the accounts list
----------------------------

Request:

  GET https://emery-md.nssecurebanking.org/api/v1/accounts?access_token=zzzzzzzzzz

Response(JSON)

 {
   "accounts": {
     "account": {
       "id": "1234",
       "name": "Super-Saver Checking",
       "balance": 123.50,
       "available": 120.00
     }
   }
 }

In all of the above requests, BudgetSketch will use the following client_id for testing:

  e077237fdfd483900657a66cd1475d6887978ded874148370e32ee7906df013f70d98bdd754d3191
