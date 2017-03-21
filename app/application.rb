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
      resp.write display_cart_msg
    elsif req.path.match(/add/)
      item = req.params["item"]
      resp.write add_to_cart_msg item
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

  def display_cart_msg
    if @@cart.empty?
      "Your cart is empty"
    else
      contents = @@cart.join("\n")
      "Your cart contains:\n#{contents}"
    end
  end

  def add_to_cart_msg(item)
    if @@items.include?(item)
      @@cart << item
      "added #{item}"
    else
      "We don't have that item"
    end
  end

end
