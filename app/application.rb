 class Application 
  
  @@items = ["Apples","Carrots","Pears"]
  @@cart = [] 

   def call(env)
    resp = Rack::Response.new 
     req = Rack::Request.new(env)
   
   
    if req.path.match(/search/)
    @@items.each do |item|
     resp.write "#{item}\n"
  
  end 
    item = req.params["q"]
      if @@items.include?(item)
        resp.write "#{item} is one of our items"
      else
        resp.write "Couldn't find #{item}"
      end
 else 
  resp.write "Path Not Found "
  resp.write "Your cart is empty" 
   resp.write @@items << "Apples\nOranges"
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

      
      
      
      