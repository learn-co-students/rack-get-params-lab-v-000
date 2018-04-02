class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/cart/)
      @@cart.each do |cart|
        resp.write "#{cart}\n"
      end

    elsif req.path.match(/search/)
      search_term = req.params["q"]

    elsif @@cart = 0
      write "Your cart is empty"
    else
      resp.write "added #{"q"}"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@cart.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return
    end
  end
end
