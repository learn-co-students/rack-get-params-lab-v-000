class Application

  @@items = ["Apples","Carrots","Pears", "Peas", "Asparagus", "Strawberries", "Blueberries"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each {|i| resp.write "#{i}\n"}
    elsif req.path.match(/cart/)
      resp.write "My Cart\n\n\n "
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        @@cart.each{|i| resp.write "#{i}\n"}
      end
    elsif req.path.match(/add/)
      item = req.params["item"]
      if @@items.include?(item)
        @@cart << item
        resp.write "added #{item}"
      else
        resp.write "Sorry! We don't have that item"
      end
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
end
