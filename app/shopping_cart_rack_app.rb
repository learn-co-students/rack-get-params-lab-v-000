class ShoppingCartRackApp
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/cart)
      @@cart.each do |item|
        resp.write "#{item}\n"
      end
    elsif @@cart.empty?
      resp.write "Your cart is empty"
    end
    resp.finish
  end

end
