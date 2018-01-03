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
      else
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end
    elsif req.path.match(/add/)
      new_item = req.params["item"]
      if @@items.include? new_item
        @@cart << new_item
        resp.write "added #{new_item}"
      else
        resp.write "We don't have that item"
      end
    else
      resp.write "Path Not Found"
    end
  
    resp.finish
  end

    def handle_search(search_term)
      if @@item.include?(search_term)
        return "#{search_term} is one of our items"
      else
        return "Couldn't find #{searh_term}"
      end
    end
  end

  



#Create a new class array called @@cart to hold any items in your cart
#Create a new route called /cart to show the items in your cart