require 'pry'
class Application

  @@cart = []
  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        @@cart.each { |item| resp.write "#{item}\n" }
      end

    elsif req.path.match(/add/)

      add_item = req.params["item"]

      if @@items.include?(add_item)
        @@cart << add_item
        resp.write "added #{add_item}"
      else
        resp.write "We don't have that item"
      end

    else
      resp.write "Path not found"
    end

    resp.finish
  end
end # Application
