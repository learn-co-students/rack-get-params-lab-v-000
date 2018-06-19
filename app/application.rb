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
			if @@cart.size == 0
				resp.write "Your cart is empty\n"
			else
				@@cart.each do |item|
					resp.write "#{item}\n"
				end
			end
		elsif req.path.match(/add/)
			add_item = req.params["item"]
			text_on_add = add_to_cart(add_item)
			resp.write text_on_add
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

	def add_to_cart(add_item)
		if @@items.include?(add_item)
			@@cart << add_item
			return "added #{add_item}\n"
		else
			return "We don't have that item\n"
		end
	end
end
