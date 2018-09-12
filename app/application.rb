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
    else
      resp.write "Path Not Found"
    end

    if @@cart.empty?
      resp.write "Your cart is empty"
    else
      @@cart .each do |cart_item|
        resp.write "#{cart_item}\n"
      end
    end

  # binding.pry
    if @@items.include?(req.params["item"])
      @@cart << req.params["item"]
      resp.write "added #{req.params["item"]}"
    else
      resp.write "We don't have that item"
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
