class Application

  @@items = ["Apples","Carrots","Pears", "Figs"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end #do_item

    elsif req.path.match(/cart/)

      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        @@cart.each do |cart_item|
          resp.write "#{cart_item}\n"
        end #do_cart_item
      end #if cart.empty?

    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)

    elsif req.path.match(/add/)
      added_item = req.params["item"]
      resp.write handle_add(added_item)

    else
      resp.write "Path Not Found"
    end # if req.match()

    resp.finish
  end #def call


  def handle_add(added_item)
    if @@items.include?(added_item)
      @@cart << added_item
      return "added #{added_item}\n"
    else
      return "We don't have that item\n"
    end #if @@items.include?(added_item)
  end #handle_add


  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
