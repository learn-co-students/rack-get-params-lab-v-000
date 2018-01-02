class Application

  @@cart = ["Apples","Carrots","Pears"]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/cart/)
      @@cart.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/add/)
      @@cart << 
        resp.write "added #{item}\n"
    else
      resp.write "We don't have that item"
    end
    resp.finish
  end
end

