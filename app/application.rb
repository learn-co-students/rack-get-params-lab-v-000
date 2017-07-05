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
      resp.write handle_search(req.params["q"])

    elsif req.path.match(/cart/)
      resp.write display_cart

    elsif req.path.match(/add/)
      resp.write add_to_cart(req.params["item"])
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

  def add_to_cart(item)
    if @@items.include?(item)
      @@cart << item
      "We have added #{item} to your cart."
    else
      "We don't have that item"
    end

  end

  def display_cart
    if @@cart.any?
      @@cart.join("\n")
    else
      "Your cart is empty"
    end


  end
end
