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
    elsif req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end
    elsif req.path.match(/add/)
      searched_item = req.params["item"]
      if handle_search(searched_item) == "Couldn't find #{searched_item}"
        resp.write "We don't have that item"
      else
        @@cart << searched_item
        resp.write "added #{searched_item}"
      end


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



#
# describe "/cart" do
#   it "responds with empty cart message if the cart is empty" do
#     Application.class_variable_set(:@@cart, [])
#     get '/cart'
#     expect(last_response.body).to include("Your cart is empty")
#   end
#
#   it "responds with a cart list if there is something in there" do
#     Application.class_variable_set(:@@cart, ["Apples","Oranges"])
#     get '/cart'
#     expect(last_response.body).to include("Apples\nOranges")
#   end
# end
