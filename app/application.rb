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
      if @@cart.empty?
        resp.write "Your cart is empty"
      else @@cart.each do |item_in_cart|
        resp.write "#{item_in_cart}\n"
        end
      end
    elsif req.path.match(/add/)
      item_for_cart = req.params["item"]
      if @@items.include?(item_for_cart) == true
        @@cart << item_for_cart
        resp.write "added #{item_for_cart} to cart.\n"
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