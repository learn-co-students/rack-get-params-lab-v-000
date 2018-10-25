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
        resp.write "Your cart is empty."
      else
        @@cart.each { |item| resp.write "#{item}\n" }
      end
    elsif req.path.match(/add/)
      item = req.params["item"]
      resp.write handle_adding_item(item)
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

  def handle_adding_item(item)
    if @@items.include?(item)
      @@cart << item
      "We added #{item} to your cart"
    else
      "We don't have that item"
    end
  end
end
