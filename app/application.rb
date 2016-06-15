
class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = ["Apple", "Pears"]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/cart/)
      resp.write give_cart
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/add/)
      search_term = req.params["item"]
      resp.write add_item(search_term)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def give_cart
    if @@cart.empty?
      return "Your cart is empty"
    else
      @@cart.join("\n")
    end
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  def add_item(search_term)
    if @@items.include?(search_term)
      @@cart << "#{search_term}"
      return "added #{search_term}"
    else
      return "We don't have that item"
    end
  end
end
