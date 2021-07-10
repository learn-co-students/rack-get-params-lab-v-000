
class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = ["Apples", "Carrots"]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif @@cart.empty?
        resp.write "Your cart is empty"
    elsif req.path.match(/cart/)
      @@cart.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/add/)
        search_term = req.params["item"]
        resp.write add_search(search_term)
    elsif req.path.match(/search/)
        search_term = req.params["q"]
        resp.write handle_search(search_term)
    else
        resp.write "Path Not Found"
    end

    resp.finish
  end

  def add_search(search_term)
    if @@items.include?(search_term)
      @@cart << search_term
      "added #{search_term}"
    else
      "We don't have that item"
    end
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
