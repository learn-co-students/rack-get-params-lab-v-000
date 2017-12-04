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
    elsif req.path.match(/cart/)
      resp.write "Your cart is empty" if @@cart == []
      @@cart.each {|c_item| resp.write "#{c_item}\n"} if @@cart != []
    elsif req.path.match(/add/)
      add_term = req.params["item"]
      resp.write handle_add(add_term)
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

  def handle_add(add_term)
    if @@items.include?(add_term)
      @@cart << add_term
      return "added #{add_term}"
    else
      return "We don't have that item"
    end
  end
end
