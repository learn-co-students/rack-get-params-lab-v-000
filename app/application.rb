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
      resp.write show_cart
      
    elsif req.path.match(/add/)
      requested_add_item = req.params["item"]

      resp.write add_item(requested_add_item)
      
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end
  
  def show_cart
    if @@cart.size == 0 
      return "Your cart is empty."
      
    else
      @@cart.join("\n")
    end
  end
  
  def add_item(item_to_be_added)
    if @@items.include?(item_to_be_added)
       @@cart << item_to_be_added

      "added #{item_to_be_added}"
    else
       return "We don't have that item"
    end
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
