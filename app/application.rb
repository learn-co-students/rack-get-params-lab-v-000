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
      if @@cart != []
        # binding.pry # @@cart => ["Apples", "Oranges"]
        @@cart.each do |i|
        resp.write "#{i}\n"
        resp.write "#{@@cart[0]}\n#{@@cart[1]}"
        end
      else
        resp.write "Your cart is empty"
      end

    elsif req.path.match(/add/)
      # @@cart = []
      item = req.params["item"]
      # binding.pry #  @@items == ["Figs", "Oranges"], item == "Figs"
# binding.pry
      if @@items.include?(item)
        @@cart << item
      #         # binding.pry # @@items == ["Figs", "Oranges"], item == "Figs", @@cart == ["Figs"]
        resp.write "added #{item}"
      else
        return "Couldn't find #{item}"
      end
        # resp.write handle_cart(item)

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

  # def handle_cart(search_term)
  #   if @@items.include?(search_term)
  #     @@cart << search_term
  #     return "added #{search_term}"
  #   else
  #     return "Couldn't find #{search_term}"
  #   end
  # end
end
