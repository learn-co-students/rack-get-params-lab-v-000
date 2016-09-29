class Application


  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

#cart code
    if req.path.match(/cart/)
        @@cart.each do |cart_item|
          resp.write "#{cart_item}\n"
        end
    else
        resp.write "Your cart is empty"
      end

#add code
    if req.path.match(/add/)
      search_term = req.params["key"]

        if @@items.include?(search_term)
          @@cart << search_term
          resp.write "added #{search_term}"
        else
          resp.write "We don't have that item"
        end

    else
          resp.write "Your cart is empty"
        end


#items code


      resp.finish

    end #call(env)
end #class app


  #if cart
	#cart code
#elsif add
	#add code
#elsif items
	#items code
#else
	#whatever
#send
