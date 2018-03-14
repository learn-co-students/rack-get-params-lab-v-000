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
  
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env) 
    
    if req.path.match(/cart/)
      @@cart each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/add/)
      item_search = req.params["q"]
      resp.write handle_add(item_search)
    else 
      resp.write "Path not found"
    end
    
    resp.finish
  end
      
  def handle_add(item_search)    
    if @@items.include(item_search)
      @@cart << item_search 
      return "#{item_search} was added to your cart."
    else 
      return "Couldn't find #{search_item}"
    end 
  end
end
