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
      resp.write @@cart.empty? ? "Your cart is empty" : @@cart.join("\n")
    elsif req.path.match(/add/)
      added_item = req.params["item"]
      resp.write handle_add(added_item)
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

  def handle_add(added_item)
    if @@items.include?(added_item)
      @@cart << added_item
      return "added #{added_item}"
    else
      return "We don't have that item"
    end
  end
end
