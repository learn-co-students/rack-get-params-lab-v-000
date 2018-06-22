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
    elsif req.path.match(/add/)
      if @@items.include?("item")
        @@cart << search_term
        return "added #{search_term}"
      else
        return "Couldn't find #{search_term}"
      end
        resp.write handle_cart(search_term)
              binding.pry
    elsif req.path.match(/cart/)
      if @@cart != []
      @@cart.each do |item|
        resp.write "#{item}\n"
      # binding.pry
      end
      else
        resp.write "Your cart is empty"
      end
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

  # def handle_cart(search_term)
  #   if @@items.include?(search_term)
  #     @@cart << search_term
  #     return "added #{search_term}"
  #   else
  #     return "Couldn't find #{search_term}"
  #   end
  end
end
