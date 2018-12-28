require 'pry'

class Application

  @@cart = []
  
  @@items = ["Apples","Carrots","Pears"]

  
  def includes(options, requests)
    product = []
    requests.each do |item|
      if options.include?(item)
        product << item 
      end 
    end 
  end 
  
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
    elsif req.path.match(/cart/) && @@cart.length > 0
      @@cart.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/cart/) && @@cart.length == 0 
      resp.write "Your cart is empty"
    elsif req.path.match(/add/) && @@items.include?(req.params["item"]) 
        @@cart << req.params["item"] 
        resp.write "added #{req.params["item"]}"
    elsif req.path.match(/add/) && !@@items.include?(req.params["item"])
      resp.write "We don't have that item"
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
