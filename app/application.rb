class Application

  @@cart = []
  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/cart/)
      if @@cart.size > 0
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      else 
        resp.write "Your cart is empty"  
      end
    elsif req.path.match(/add/)
      new_item = req.params["item"]
      resp.write handle_item(new_item)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_item(new_item)
    if @@items.include?(new_item)
      @@cart << new_item
      return "added #{new_item}"
    else
      return "We don't have that item"
    end
  end
end
