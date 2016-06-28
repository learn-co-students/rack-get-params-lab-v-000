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
    else
      resp.write "Path Not Found\n"
      resp.write "Your cart is empty"
    end
    #ADD CODE HERE
    if req.path.match(/add/)
      get_param = req.params["item"]
      if @@items.include?(get_param)
        @@cart << get_param
        resp.write "added #{get_param}"
      else
        resp.write "We don't have that item"
      end
    end

    #CART CODE HERE
    if req.path.match(/cart/)
      @@cart.each do |cart_item|
       resp.write "#{cart_item}\n" 
      end
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
end
