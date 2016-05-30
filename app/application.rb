class Application

  @@items = [ ]
  @@cart = []
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    if req.path.match(/cart/)
      if !@@cart.empty?
        @@cart.collect do |cart|
          resp.write "#{cart}\n"
        end
      else
        resp.write "Your cart is empty"
      end

    elsif req.path.match(/add/)
      search_term = env['QUERY_STRING'].gsub('item=','')
      resp.write handle_search(search_term)
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      @@cart << search_term
      return "added Figs\n"
    else
      return "We don't have that item\n"
    end
  end
end
