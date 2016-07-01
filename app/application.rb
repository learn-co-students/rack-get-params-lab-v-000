
class Application
  attr_accessor :resp, :req
  @@items = ["Apples","Carrots","Pears"]
  @@cart  = []

  def handle_search(search_term)
    if @@items.include?(search_term)
      @@cart << search_term
      resp.write("added #{search_term}")
    else
      resp.write "We don't have that item"
    end
  end

  def execute_path
    case
    when req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    when req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    when req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end
    when req.path.match(/add/)
      search_term = req.params["item"]
      handle_search(search_term)
    else
      resp.write "Path Not Found"
    end

  end

  def call(env)
    self.resp = Rack::Response.new
    self.req = Rack::Request.new(env)

    execute_path
    resp.finish
  end

end
