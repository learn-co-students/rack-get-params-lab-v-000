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
      if @@cart == []
        resp.write "Your cart is empty."
      else
        @@cart.each do |items|
          resp.write "#{items}\n"
        end
      end
    elsif req.path.match(/add/)
      search_item = req.params["item"]
      if @@items.include?(search_item)
        i = search_item
        @@cart << i
        resp.write "added #{i}"
    else
      resp.write "We don't have that item."
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
end
