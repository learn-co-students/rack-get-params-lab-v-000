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
      resp.write display_cart
    elsif req.path.match(/add/)
      added_item = req.params["item"]
      if @@items.include?(added_item)
        @@cart << added_item 
        resp.write "added #{added_item}"
      else
        resp.write "We don't have that item"
      end
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def display_cart
    if @@cart.empty?
      return "Your cart is empty."
    end
    header = "" # "Your cart items are:\n ---------------------\n"
    @@cart.each.with_index do |item, index|
      # header += "#{index + 1}. #{item}\n"
      header += "#{item}\n"
    end
    return header
  end

  def handle_search(search_term)
    if @@items.map{|i| i.downcase}.include?(search_term.downcase)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
