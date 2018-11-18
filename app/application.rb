class Application

  @@cart = []
  @@items = ["Apples","Carrots","Pears"]

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
      check_cart(resp)
    elsif req.path.match(/add/)
      search_term = req.params["item"]
      item_search(search_term, resp)
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

  def check_cart(resp)
    if @@cart.empty?
    resp.write "Your cart is empty"
    else
      @@cart.each do |item|
        resp.write "#{item}\n"
      end
    end
  end

  def item_search(search_term, resp)
    if @@items.include?(search_term)
      @@cart << search_term
      resp.write "added #{search_term}"
    else
      resp.write "We don't have that item"
    end
  end
end
