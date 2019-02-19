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
    elsif req.path.match(/cart/) 
      if @@cart.empty? 
        resp.write "Your cart is empty" 
      else
        @@cart.each { |thing| resp.write "#{thing}\n" } 
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/add/)
      wanted_item = req.params["item"] 
      resp.write add_item_to_cart(wanted_item)
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

  def add_item_to_cart(wanted_item) 
    if @@items.include?(wanted_item) 
      @@cart << wanted_item 
      return "added #{wanted_item}" 
    else 
      return "We don't have that item" 
    end 
  end 
end
