class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = ["Apples"]

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
      item_term = req.params["item"]
      resp.write handle_item(item_term)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      "#{search_term} is one of our items"
    else
      "Couldn't find #{search_term}"
    end
  end

  def handle_cart
    if @@cart.empty?
      "Your cart is empty"
    else
      @@cart.join("\n")
    end
  end

  def handle_item(item_term)
    if @@items.include?(item_term)
      @@cart << item_term
      "added #{item_term}"
    else
      "We don't have that item"
    end
  end
end
