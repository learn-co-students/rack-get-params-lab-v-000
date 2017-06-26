class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = [ ]

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
    elsif req.path.match(/cart/) && @@cart.any?
      @@cart.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/cart/) && @@cart.empty?
      resp.write "Your cart is empty"

    elsif req.path.match(/add/)

      add_item = req.params["item"]

      if @@items.include?(add_item)
        @@cart << add_item
        resp.write "added #{add_item}"
      else
        resp.write "We don't have that item"
      end


    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  # 2. Create a new route called `/cart` to show the items in your cart
  # 3. Create a new route called `/add` that takes in a `GET` param with the key `item`.
  # This should check to see if that item is in `@@items` and then add it to the cart if it is. Otherwise give an error

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
