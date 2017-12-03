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

    if req.path.match(/cart/)
      if @@cart.size >= 1
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      else
        resp.write "Your cart is empty"
      end
    end

    if req.path.match(/add/)
      new_item = env["QUERY_STRING"][5..-1]
      if @@items.include?(new_item)
       @@cart << new_item
       resp.write "added #{new_item}"
      else
       resp.write "We don't have that item"
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
