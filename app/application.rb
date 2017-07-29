class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/cart/)
      if @@cart == []
        resp.write "Your cart is empty"
      else
        @@cart.each do |c|
          resp.write "#{c}\n"
        end
      end
    end

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    end

    if req.path.match(/add/)
      query = req.params["item"]
      if @@items.include?(query)
        @@cart << query
        resp.write "added #{query}"
      else
        resp.write "We don't have that item"
      end
    end

    if req.path.match(/search/)
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
