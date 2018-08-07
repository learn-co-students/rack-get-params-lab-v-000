require 'pry'

class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []


   def call(env)
     resp = Rack::Response.new
     req = Rack::Request.new(env)

     if req.path.match(/items/)
       @@items.each do |item|
         resp.write "#{item}\n"
       end
     elsif req.path.match(/search/)
       search_term = req.params["q"]
       resp.write handle_search(search_term)
     elsif req.path.match(/cart/)
       resp.write handle_cart
     elsif req.path.match(/add/)
       item = req.params["item"]
       resp.write handle_add(item)
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


  def handle_cart
    if @@cart.size == 0
      "Your cart is empty"
    else
      @@cart.join("\n")
    end
  end

  def handle_add(item)
    if @@items.include?(item)
      @@cart << item
      "added #{item}"
    else
        "We don't have that item"
    end
    # binding.pry
  end
end
