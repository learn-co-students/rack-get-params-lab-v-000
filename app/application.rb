require 'pry'
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
    else
      resp.write "Path Not Found"
    end

    if @@cart.empty?
      resp.write "Your cart is empty"
    else
      req.path.match(/cart/)
      @@cart.each do |item|
        resp.write "#{item}\n"
      end
    end

    if req.path.match(/add/)
      @@items.each do |item|
        #binding.pry
        if @@items.include?(item)
          @@cart << item
          resp.write "added #{item}"
          binding.pry
        else
          resp.write "We don't have that item"
        end
      end
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
