class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    if req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        @@cart.each do |cartitem|
          resp.write "#{cartitem}\n"
        end
      end
    elsif req.path.match(/add/)
      env["QUERY_STRING"].slice!(0,5)
        if @@items.include?(req.query_string)
          @@cart << req.query_string
          resp.write "added #{req.query_string}"
        elsif !@@items.include?(req.query_string)
          resp.write "We don't have that item"
        end
      end
    # elsif req.path.match(/search/)
    #   search_term = req.params["q"]
    #   resp.write handle_search(search_term)
    # else
    #   resp.write "We don't have that item"
    # end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      "added #{search_term}"
    else
      return "Your cart is empty"
    end
  end
end
