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
      item_to_add = req.params["item"]
      resp.write add_item_to_cart(item_to_add)
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
    if @@cart.empty?
      "Your cart is empty."
    else
      output = ["Your cart includes the following items:"]
      @@cart.each do |item|
        output << item
      end
      output.join("\n")
    end
  end

  def add_item_to_cart(item_to_add)
    if @@items.include?(item_to_add)
      @@cart << item_to_add
      "We've added #{item_to_add} to your cart."
    else
      "We don't have that item."
    end
  end
end
