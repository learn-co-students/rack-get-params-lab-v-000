require 'pry'
class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    #binding.pry


    #/items/ # Get param
    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
   elsif req.path.match(/cart/)
       if @@cart.empty?
          resp.write "Your cart is empty"
       else
           @@cart.each do |cart_item|
               resp.write "#{cart_item}\n"
            end
       end
  elsif req.path.match(/add/)
      add_search_term = req.params["item"] #= Figs
      binding.pry
      if @@items.include?(add_search_term)
          @@cart << add_search_term
          resp.write "added #{add_search_term}"
      end
      binding.pry
  elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
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
