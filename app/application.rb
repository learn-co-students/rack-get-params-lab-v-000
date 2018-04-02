class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  # the req.path.match   is simple regex method to find /items/

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
        # or we can say @@cart.length == 0

        resp.write "Your cart is empty"
      else
        @@cart.each do |item_in_cart|
          resp.write"#{item_in_cart}\n"
        end
      end

    elsif req.path.match(/add/)
      add_item = req.params["item"]
      if @@items.include?(add_item)
        @@cart << add_item
        #  binding.pry
        resp.write "added #{add_item}"
      else
        resp.write "We don't have that item"
      end
    end
    resp.finish
  end

end
