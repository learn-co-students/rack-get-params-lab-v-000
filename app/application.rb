require 'pry'
class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n" # /n just indicates the start of a new line
      end #End to .each loop

      elsif req.path.match(/search/)
        search_term = req.params["q"]
        resp.write handle_search(search_term)

      elsif req.path.match(/cart/)
        if @@cart.empty?
          resp.write "Your cart is empty"
        else
          @@cart.each do |item_in_cart|
            resp.write "#{item_in_cart}\n"
          end #End of .each loop
        end #End of if-statement


    elsif req.path.match(/add/)

      item_to_be_added = req.params["item"]

      if @@items.include?(item_to_be_added)
        @@cart.push(item_to_be_added)
        resp.write "added #{item_to_be_added}"
      else
        resp.write "We don't have that item!"
      end
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end #End to #call method

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end #End to #handle_search method

end
