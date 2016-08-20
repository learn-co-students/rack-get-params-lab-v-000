class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart =[]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    # --responds with a  list of items if there is something in there
    if req.path.match(/items/) # the path
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    # --Below is.equal_to (search?q=Apples)
    # --You are making a search query with search as the path and q=item as the search query
    elsif req.path.match(/search/)
      # -- making a GET request (the GET parameters) below
      search_term = req.params["q"]
      # --responds with a cart list if there is something in there
      resp.write handle_search(search_term)
      # --below is.equal_to == cart (so you are displaying what is inside the cart)
    elsif req.path.match(/cart/) # the path
      # --responds with empty cart message if the cart is empty
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        @@cart.each do |cart_item|
          resp.write "#{cart_item}\n"
        end
      end
      # --below is.equal_to == (add?item=Apples)
    elsif req.path.match(/add/) # --the path == (add?)
      # -- making a GET request (the GET parameters) below
      item_to_add = req.params["item"] # --the search == (item=Apples)
      # --Will add an item that is in the @@items list
      if @@items.include?(item_to_add)
        @@cart << item_to_add
        resp.write "added #{item_to_add}"
      else
        # --Will not add an item that is not in the @@items list
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
      return "We don't have that item"
    end
  end

end
