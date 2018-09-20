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
      
      # route to show items in the cart
     elsif req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty."
      else
        @@cart.each do |grocery|
          resp.write "#{grocery}\n"
        end
      end
      # route that takes in a GET param with key item. Checks to see if item is in @@items and then adds to cart if it is. Otherwise erro.
      elsif req.path.match(/add/)
         new_item = req.params["item"]
          if @@items.include? new_item
            @@cart << new_item
            resp.write "added #{new_item}"
          else
            resp.write "We don't have that item!"
         end
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
