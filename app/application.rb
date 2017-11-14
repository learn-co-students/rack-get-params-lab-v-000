class Application

  @@items = ["Apples","Carrots","Pears"]

  @@cart = [ ]



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
    else
      resp.write "Path Not Found"
    end

      # I added:
    if req.path.match(/cart/)
      if cart.empty?
        resp.write "Your cart is empty"
      else
        cart.each { |item| resp.write "#{item}\n" }
      end
    end

      # I added:
    if req.path.match(/add/)
      # added_item = req.params["GET"] # Note that GET is a key value here...something will look like
                                    # Get=some_item
                                    # But the test says item=figs...so key in next line has to be "item"
                                    # If this is the assignment: Create a new route called /add that takes
                                    # in a GET param with the key item.  
                                      # ... then a GET param must mean just a param...something with a ?key=
      added_item = req.params["item"]
      if @@items.include?(added_item)
        @@cart << added_item
        resp.write "added #{added_item}"
      else
        resp.write "We don't have that item"
      end
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items" # why do they use "return" here?
    else
      return "Couldn't find #{search_term}"
    end
  end


  def cart
    @@cart
  end

end
