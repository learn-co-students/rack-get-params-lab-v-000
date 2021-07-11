# Rack Routes and GET Params

We've provided the code for a basic list of items. Now it's your turn to extend it.
Do your work in `app/application.rb`.

## Vocabulary Word: "Route"

In applications built on Rack, we use the noun "route" to refer to a path
that the application has a special response to.

So, for example, if we navigated to a `/shoes` route, we would expect the
application to show us information about shoes. A `/profile` route might show
information about a user who's logged in to an application. Finally, a `/logout`
route might update some information to let the server know the user is no longer
logged in.

## Instructions

  1. Create a new class array called `@@cart` to hold any items in your cart.
  2. Create a new route called `/cart` to show the items in your cart.
  3. Create a new route called `/add` that takes in a `GET` param with the key `item`. This should check to see if that item is in `@@items` and add it to the cart if it is. Otherwise it should give an error.
