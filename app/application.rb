
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
    else
      resp.write "Your cart is empty"
    end


    if req.path.match(/cart/)
      @@cart.each do |cart_item|
        resp.write "#{cart_item}\n"
      end

    elsif @@items.include?(search_term)
      @@cart << search_term
      resp.write "added #{search_term}"
    elsif @@items.include?(search_term)==false
      resp.write "We don't have that item"
    else
      resp.write "We dont' have that item"
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

  #if cart
	#cart code
#elsif add
	#add code
#elsif items
	#items code
#else
	#whatever
#send


end
