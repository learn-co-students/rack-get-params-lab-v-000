class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(environment)
    resp = Rack::Response.new
    req = Rack::Request.new(environment)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
    end
    elsif req.path.match(/search/)
      search = req.params["q"]
      resp.write handle(search)
    elsif req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end
    elsif req.path.match(/add/)
      search = req.params["item"]
        if @@items.include?(search)
          @@cart << search
          resp.write "added #{search}"
        else
          resp.write "We don't have that item"
        end
    else
      resp.write "Path Not Found"
    end
      resp.finish
  end

  def handle(fruit)
    if @@items.include?(fruit)
      return "#{fruit} is one of our items"
    else
      return "Couldn't find #{fruit}"
    end
  end
end
