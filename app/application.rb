class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    msg = if req.path.match(/items/)
      @@items.join("\n")
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      handle_search(search_term)
    elsif req.path.match(/cart/)
      @@cart.empty? ? "Your cart is empty" : @@cart.join("\n")
    elsif req.path.match(/add/)
      item = req.params["item"]
      handle_add(item) ? "added #{item}" : "We don't have that item!"
    else
      "Path Not Found"
    end
    resp.write(msg)
    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  def handle_add(item)
    @@items.include?(item) ? @@cart << item : nil
  end

end
