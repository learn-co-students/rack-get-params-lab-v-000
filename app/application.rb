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
          if @@cart.empty?
       # or we can say @@cart.length == 0
       binding.pry

           resp.write "Your cart is empty"
         else
          @@cart.each do |item_in_cart|
            resp.write"#{item_in_cart}\n"
          end
         end



         #this works till here. 

       elsif req.path.match(/add/)
            add_item = req.params["item"]
          if @@items.include?(add_item)
               @@cart << add_item
           else
                resp.write "404"
         end
        end
      #  end

 # >>>>>>>>>>>>



    # else
    #
    #  resp.write "Path Not Found"
    # end
    #
    #    resp.finish
    #  end

    #  def handle_search(search_term)
    #    if @@items.include?(search_term)
    #      return "#{search_term} is one of our items"
    #    else
    #      return "Couldn't find #{search_term}"
    #    end
    #  end



 #    if req.path.match(/items/)
 #      # note.. you can add a if with in a if statment. (nesting if statment)
 #      if @@cart.empty?
 #        # or we can say @@cart.length == 0
 #        resp.write "Your cart is empty"
 #      else
 #        @@cart.each do |cart|
 #
 #          resp.write "#{cart}\n"
 #        end
 #      end
 #    end
 #
 #    if req.path.match(/search/)
 #      search_term = req.params["q"]
 #      if @@cart.include?(search_term)
 #        resp.write "added #{"q"}"
 #      else
 #        resp.write "Item not found"
 #      end
 #
 #    elsif req.path.match(/add/)
 #      add_item = req.params["item"]
 #      binding.pry
 #      if @@items.include?(add_item)
 #         @@cart << add_item
 #      else
 #        resp.write "404"
 #      end
 #    else
 #      resp.finish
 #    end
  # end
 # end
