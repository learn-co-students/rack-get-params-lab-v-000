class Application

  @@items = ["Apples","Carrots","Pears"]
  #Create a new class array called @@cart to hold any items in your cart
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

#Create a new route called /cart to show the items in your cart
    elsif req.path.match(/cart/)
      resp.write show_cart

#Create a new route called /add that takes in a GET param with the key item
#This should check to see if that item is in @@items and then add it to the cart if it is. Otherwise give an error
    elsif req.path.match(/add/)
      add_item = req.params["item"]
      resp.write add_item

    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def show_cart
    if @@cart.size == 0
      return "Your cart is empty"
    else
      return @@cart.join("\n")
    end
  end

  def add_item
    if @@items.include?(add_item)
       @@items << add_item
       resp.write "added #{add_item}"
      #return @@cart.join|add_item|
    else
       return "We don't have that item"
    end
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
