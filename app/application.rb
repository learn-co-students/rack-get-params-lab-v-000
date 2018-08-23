class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    #here we can write if else statement checking to see what path is being passed in...all of this needs to be in call method

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)#if the path they're plugging in matches cart, do this
      if @@cart.empty?
        resp.write "Your cart is empty."
      else
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end
    elsif req.path.match(/add/)
      added_item = req.params["item"]#item is the key
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

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
