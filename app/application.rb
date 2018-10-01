require 'pry'
class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new #this sets a variable to the rack response class
    req = Rack::Request.new(env)

    if req.path.match(/cart/) #this is a route
      if @@cart.empty?
        resp.write "Your cart is empty."
      elsif
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      else
      end
    end

    #Create a new route called /add that takes in a GET param with the key item.
    #This should check to see if that item is in @@items and then add it to the cart if it is.
    #Otherwise give an error

    if req.path.match(/add/) #add is the route
      new_item = req.params["item"] #item is the key set to added_item
      if @@items.include?(new_item) #checks if @@items has the item
        @@cart << new_item #if not adds it to cart
        resp.write "added #{new_item}."
      else
        resp.write "We don't have that item"
      end
    end

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
