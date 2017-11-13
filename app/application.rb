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

    elsif req.path.match(/cart/)
      if @@cart.empty?
         resp.write "Your cart is empty"
      else
         @@cart.each {|item| resp.write "#{item}\n"}
      end
    elsif req.path.match(/add/)
            search_term = req.params["item"]  # this method is taking in a GET param with a key of "item"

            if @@items.include?(search_term)
                @@cart << search_term
                resp.write "added #{search_term}"
            else
              resp.write "We don't have that item"
            end


    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    else
      resp.write "Path Not Found"
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
