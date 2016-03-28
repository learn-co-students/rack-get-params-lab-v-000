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
    
    elsif req.path.match(/add/)
      add_item = req.params["item"]
      resp.write handle_add(add_item)
  
    elsif req.path.match(/cart/)
      resp.write handle_cart

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
    if @@cart.size == 0
      return "Your cart is empty"
    else
      # @@cart.each{|i| print "#{i}\n"}
      @@cart.each do |item|
        return "#{item}\n"
      end
    end
  end

  def handle_add(add_item) 
    if @@items.include?(add_item)
      @@cart.push(add_item)
      return "added #{add_item}"
    else
      return "We don't have that item"
    end 
  end

end 