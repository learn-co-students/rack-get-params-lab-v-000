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
      
      if !@@cart.include?(add_item)
        @@cart << add_item
        resp.write "added #{add_item}"
      else
        resp.write "We don't have that item"
      end
      
      #@@cart << add_item if !@@cart.include?(add_item)
    
    
    ### Path Not Found
    else
      resp.write "Path Not Found"
    end
    
    
    # respond with a cart list if there is something in there
    #if @@cart == true
    #  @@cart.each do |item|
    #    resp.write "#{item}"
    #  end
    #end
    
    
    # respond with empty cart message if the cart is empty
    #if @@cart.empty?
    #  resp.write "Your cart is empty"
    # respond with a cart list if there is something in there
    #else
    #  resp.write "#{@@cart}"
    #end
    
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


    #search_term = req.params["q"]
 
    #if @@items.include?(search_term)
      #resp.write "#{search_term} is one of our items"
    #else
      #resp.write "Couldn't find #{search_term}"
    #end