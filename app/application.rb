class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  #create new array class @@cart
  #new route /cart
  #new route /add - takes GET with k item
    #check if that item is in @@items, add to cart if it is otherwise error

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
        if @@items.include? req.params["item"]
          @@cart << req.params["item"]
          resp.write "added #{req.params["item"]}"
        else
          resp.write "We don't have that item"
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
