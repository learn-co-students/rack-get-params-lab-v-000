class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/cart/) && @@cart == []
        resp.write "Your cart is empty."
    elsif req.path.match(/cart/)
       @@cart.each do |item|
        resp.write "#{item}\n"
        end
    elsif req.path.match(/add/)
      search_term = req.params["item"]
      resp.write handle_search(search_term)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      @@cart << search_term
      return "added #{search_term}"
    else
      return "We don't have that item"
    end
  end
end
