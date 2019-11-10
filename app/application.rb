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
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
      resp.write @@cart.join("\n")
    end
    elsif req.path.match(/add/)
      cart_item = req.params["item"]
      if @@items.include?(cart_item)
        @@cart << cart_item
        resp.write "added #{cart_item}"
      else
        resp.write "We don't have that item"
      end
      # This should take in a get param with the key item
      # check to see if item is in @@items, if so add to cart, otherwise give an error.
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
