class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart=[]
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end

    elsif req.path.match(/cart/)
      @@cart.each do |item|
        resp.write "#{item}\n"
      end
      if @@cart.empty?
        resp.write "Your cart is empty"
      end

    elsif req.path.match(/add/)
      add = req.params["item"]
        if @@items.include?(add)
          @@cart << "#{req.params["item"]}"
            resp.write "added #{req.params["item"]}"
        else
              resp.write "We don't have that item"
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
end
