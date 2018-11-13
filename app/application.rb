class Application

  @@items = ["Apples","Carrots","Pears"]
  
  # Array to hold items in cart
  @@cart = []
  
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    
    ### /items
    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    
    
    ### /cart
    elsif req.path.match(/cart/)
      
      if @@cart.empty? # Print Cart is Empty if Empty
        resp.write "Your cart is empty"
      else # Print the Cart
        @@cart.each {|kart| resp.write "#{kart}\n"}
      end
    
    
    ### /add  
    elsif req.path.match(/add/)
      
      add_item = req.params["item"]
      
      if @@items.include?(add_item)
        @@cart << add_item
        resp.write "added #{add_item}"
      else
        resp.write "We don't have that item."
      end
      
      
    ### Path Not Found
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
  
  
end