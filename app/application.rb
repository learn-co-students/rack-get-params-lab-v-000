class Application

  @@items = ["Apples","Carrots","Pears"]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

#### finds items path. returns all items
    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
#### finds cart path. Detects empty, or prints cart.
    elsif req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end
#### finds add path. Add possible? ? add : error
    elsif req.path.match(/add/)
      add_request = req.params["item"]
      if @@items.include?(add_request)
        @@cart << "#{req.params["item"]}"
        resp.write "added #{req.params["item"]}"
      else
        resp.write "We don't have that item"
      end
#### finds search path. IDs search term 
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
end
