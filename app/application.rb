class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      display_commerce(@@items, resp)
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      if @@cart.empty? == true
        resp.write "Your cart is empty"
      else
        display_commerce(@@cart, resp)
      end
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def display_commerce(container, response)
    container.each do |item|
      response.write "#{item}\n"
    end
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
