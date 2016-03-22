class Application

  @@cart = []
  @@items =[]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/cart/)
    
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end
    
    elsif req.path.match(/add/)
    
      search_term = req.params["item"]  
      if @@items.include?(search_term)
        @@cart << search_term
        resp.write "You added #{search_term}"
      else
        resp.write "We don't have that item"
      end
   
    else
   
      resp.write "Path Not Found" 
   
    end

    resp.finish
  end

end
