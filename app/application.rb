class Application

  @@items = ["Apples","Carrots","Pears"]

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
      @@cart.empty? ? 
        (resp.write"Your cart is empty") : 
        (resp.write @@cart.join("\n"))
    elsif req.path.match(/add/)
      desired_item = req.params["item"]
      resp.write handle_add(desired_item)
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

  def handle_add(desired_item)
    if @@items.include?(desired_item)
      @@cart << desired_item
      return "added #{desired_item}"
    else
      return "We don't have that item"
    end
  end
end
