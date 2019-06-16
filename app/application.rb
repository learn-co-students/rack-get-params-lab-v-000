class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = ["airpods", "ipad", "macbookpro", "homepod"]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    # /cart
    if req.path.match(/cart/)
      if !@@cart.empty?
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      else
        resp.write "Your cart is empty"
      end
    elsif req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end

      # /add
    elsif req.path.match(/add/)
      selection = req.params["item"]
      resp.write handle_selection(selection)

      # /search
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

  def handle_selection(selection)
    if @@items.include?(selection)
      @@cart << selection
      return "added #{selection}"
    else
      return "We don't have that item"
    end
  end
end
