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
      if @@cart.any?
        @@cart.each do |c|
          resp.write "#{c}\n"
        end
      else
        resp.write "Your cart is empty"
      end
    elsif req.path.match(/add/)
      potential_item = req.params["item"]

      if exists?(potential_item)
        add_to_cart(potential_item)
        resp.write "added #{potential_item}"
      else
        return_error(resp, "We don't have that item")
      end
    else
      return_error(resp, "path not found")
    end

    resp.finish
  end

  def add_to_cart(item)
    @@cart << item
  end

  def return_error(response, message)
    response.write "#{message}"
  end

  def exists?(item)
    if @@items.include?(item)
      true
    else
      false
    end
  end

  def handle_search(search_term)
    if exists?(search_term)
      # @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
