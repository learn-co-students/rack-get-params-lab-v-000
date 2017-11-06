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
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end

    elsif req.path.match(/add/)
      add_item = req.params["item"]

      if @@items.include?(add_item)
          @@cart << add_item
          resp.write "added #{add_item}"
      else
        resp.write "We don't have that item"
      end
    end
  resp.finish
  end
end
