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

#responds with empty cart message if the cart is empty
#or if @@cart.length == 0
    elsif req.path.match(/cart/) && @@cart.empty?
      resp.write "Your cart is empty"
#responds with a cart list if there is something in there
    elsif req.path.match(/cart/) && !@@cart.empty?
      @@cart.each do |item|
        resp.write "#{item}\n"
      end#of do

#Will ADD an item that is in the @@items list
    elsif req.path.match(/add/)
#set a variable to look for item
      item = req.params["item"]
#if item is included in search, add it to @@cart
        if @@items.include?(item)
           @@cart << item
#i.e. "added soap" if soap was searched
           resp.write "added #{item}."
         else
           resp.write "We don't have that item"
         end

    else
      resp.write "Path Not Found"
    end

    resp.finish
  end
#Will add an item that is in the @@items list
  def handle_search(search_phrase)
    if @@items.include?(search_phrase)
      return "#{search_phrase} is one of our items"
    else
      return "Couldn't find #{search_phrase}"
    end
  end
end
