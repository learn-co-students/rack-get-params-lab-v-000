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
    end


    if req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    else
      resp.write "Path Not Found"
    end
  

    if req.path.match(/add/)
     item_exists = req.params["item"]
     @@items.each do |i|
       if i == item_exists
         @@cart << i
         resp.write "added #{i}"
       else
         resp.write "We don't have that item"
       end
      end
    end


    if req.path.match(/cart/)
      unless @@cart == []
        @@cart.each do |content|
          resp.write "#{content}\n"
        end
      else resp.write "Your cart is empty"
      end
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