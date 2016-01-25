class Application
  @@cart = []
  @@items = ["Apples","Carrots","Pears", "F"]
  
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/cart/)
      cart_status(resp)
    elsif req.path.match(/add/)
      item = req.params["item"]
      handle_add(item, resp)
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

  def handle_add(item, resp)
    if @@items.include?(item)
      resp.write "added #{item}"
      @@cart << item
    else
      resp.write "We don't have that item"
    end
  end

  def cart_status(resp)
    if @@cart.empty?
      resp.write "Your cart is empty"
    else
      @@cart.each do |item|
        resp.write "#{item}\n"
      end
    end
  end

end

