class ShoppingCartRackApp
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if @@cart.empty?
      resp.write "Your cart is empty"
    elsif req.path.match(/cart)
      @@cart.each do |item|
        resp.write "#{item}\n"
      end
    end
    
    resp.finish
  end

end
