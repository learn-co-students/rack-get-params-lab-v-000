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
      search_term = req.params["q"].capitalize
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      resp.write cart
    elsif req.path.match(/add/)
      add_item = req.params["item"].capitalize
      resp.write add(add_item)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      "#{search_term} is one of our items"
    else
      "Couldn't find #{search_term}"
    end
  end

  def cart
    if @@cart.empty?
      "Your cart is empty"
    else
      @@cart.join("\n")
    end
  end

  def add(item)
    if @@items.include?(item)
      @@cart << item
      "added #{item}"
    else
      "We don't have that item."
    end
  end
end
