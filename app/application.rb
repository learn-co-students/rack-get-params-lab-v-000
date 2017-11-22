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


      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end

    elsif req.path.match(/add/)
      item_req = req.params["item"]
      if @@items.include?(item_req)
        if @@cart.include?(item_req)
          resp.write "item is in the cart"
        else
            resp.write "added Figs"
            @@cart << item_req
          end
      else
        resp.write "We don't have that item"
        @@items << item_req
      end

    else
      resp.write "Path Not Found"
    end

    resp.finish
  end#call

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end #handle_search
end #Application
