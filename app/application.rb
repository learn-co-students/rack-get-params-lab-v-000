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
      resp.write "Path Not Found\nYour cart is empty\n"
    end
    
    if req.path.match(/cart/) 
       @@cart.each do |item|
         resp.write "#{item}\n"
       end
     elsif req.path.match(/add/)
       search_term = req.params["item"]
       resp.write add(search_term)
     else
       resp.write "Path Not Found\nYour cart is empty\n"
    end
    
  #  if req.path.match(/add/)
  #    search_term = req.params["q"]
  #    resp.write add(search_term)
  #  else
  #     resp.write "Path Not Found\nYour cart is empty\nWe don't have that item\n"
  #  end
  #
    resp.finish
  end
  
  def add(search_term)
    if @@items.include?(search_term)
       @@cart << search_term
       return "added #{search_term}"
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
