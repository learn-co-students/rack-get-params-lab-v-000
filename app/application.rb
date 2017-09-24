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
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end
    elsif req.path.match(/add/)
      item_to_add = req.params["item"]
      resp.write handle_add(item_to_add)
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

  def handle_add(item_to_add)
    if @@items.include?(item_to_add)
      @@cart << item_to_add
      return "added #{item_to_add}"
    else
      return "We don't have that item"
    end
  end

end

#run rackup config.ru to test.
#visit localhost:9292

# http://localhost:9292/items
  # Apples
  # Carrots
  # Pears

# http://localhost:9292/cart
  # Your cart is empty

# http://localhost:9292/add?item=Apples
  # added Apples

# http://localhost:9292/add?item=Grapes
  # We don't have that item

# http://localhost:9292/cart
  # Apples





# FROM RACK REQUEST README
# @@items = ["Apples","Carrots","Pears"]
#
# def call(env)
#   resp = Rack::Response.new
#   req = Rack::Request.new(env)
#
#   if req.path.match(/items/)
#     @@items.each do |item|
#       resp.write "#{item}\n"
#     end
#   elsif req.path.match(/search/)
#
#     search_term = req.params["q"]
#
#     if @@items.include?(search_term)
#       resp.write "#{search_term} is one of our items"
#     else
#       resp.write "Couldn't find #{search_term}"
#     end
#
#   else
#     resp.write "Path Not Found"
#   end
#
#   resp.finish
# end
