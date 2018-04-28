class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new #new response instance
    req = Rack::Request.new(env) #new request instance

    if req.path.match(/items/) #for /items path only, iterate through and list each item in @@items
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/) #for /search path only, call #handle_search method. if the search_term is in @@items,
      #it returns a response.
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty"
      else @@cart.each do |cart_item|
        resp.write "#{cart_item}\n"
      end
    end
    elsif req.path.match(/add/)
      added_item = req.params["item"]
      if @@items.include?(added_item)
        @@cart << added_item
        resp.write "added #{added_item}"
      else
        resp.write "We don't have that item"
      end 
    else
      resp.write "Path Not Found" #for neither /items nor /search, return "Path Not Found"
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
