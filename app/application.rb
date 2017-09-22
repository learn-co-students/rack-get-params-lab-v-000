class Application
  @@cart = []
  @@items = ["Apples","Carrots","Pears"]

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
    elsif @@cart.empty?
      resp.write "Your cart is empty"

    elsif req.path.match(/cart/)
      @@cart.each{|item| resp.write "#{item}\n"}

    elsif req.path.match(/add/)
      search_term = req.params["item"]
      
       if handle_search(search_term).include?("is one of our items")
          @@cart<<search_term
          resp.write "added Figs"
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
