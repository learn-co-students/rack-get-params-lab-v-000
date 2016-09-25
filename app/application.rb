
class Application


  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)


    if req.path.match(/cart/)
        @@cart.each do |cart_item|
          resp.write "#{cart_item}\n"
        end
      else
        resp.write "Your cart is empty"
    end

      elsif req.path.match(/add/)
        search_term = req.params["key"]
             @@items.include?(search_term)
             @@cart << search_term
             resp.write "added #{search_term}"
          else
             resp.write "We don't have that item"
        end

      elsif req.path.match(/items/)
        @@items.each do |item|
          resp.write "#{item}\n"
        end
      elsif req.path.match(/search/)
        search_term = req.params["q"]
        resp.write handle_search(search_term)
      else
        resp.write "Your cart is empty"
      end

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
