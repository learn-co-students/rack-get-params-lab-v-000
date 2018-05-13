class Application

  @@items = ["Apples","Carrots","Pears"]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    case req.path
    when /items/
      @@items.each do |item|
        resp.write "#{item}\n"
      end

    when /search/
      search_term = req.params["q"]
      resp.write handle_search(search_term)

    when /cart/
      @@cart.each do |item|
        resp.write "#{item}\n"
      end
      if @@cart.size == 0
        resp.write "Your cart is empty"
      end

    when /add/
      if @@items.include?(req.params['item'])
        @@cart << req.params['item']
        resp.write "added #{req.params['item']}\n"
      else
        resp.write("We don't have that item")
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
