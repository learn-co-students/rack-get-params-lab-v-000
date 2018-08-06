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
      item = req.params["item"]
      resp.write add(item)
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
    if @@cart == []
      return "Your cart is empty"
    else
      @@cart.join("\n")
    end
  end

  def add(item)
    if @@items.include?(item)
      @@cart << item
    return "added #{item}"
    else 
      return "We don't have that item"
    end
  end
  # Create a new route called /add that takes in a GET param with the key item. 
  # This should check to see if that item is in @@items and then add it to the cart if it is. 
  # Otherwise give an error


  # if req.path.match(/cart/)
  #   @@cart.each do |cart|
  #     resp.write "#{cart}\n"
  #   end
  # elsif req.path.match(/search/)
  #   search_term = req.params["q"]
  #   resp.write handle_search(search_term)
  # else
  #   resp.write "Path Not Found"
  # end

  
end
