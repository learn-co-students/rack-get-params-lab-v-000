class Application
   @@items = %w[Apples Carrots Pears]
   @@cart = []

   def call(env)
      resp = Rack::Response.new
      req = Rack::Request.new(env)

      if req.path =~ /items/
         @@items.each do |item|
            resp.write "#{item}\n"
         end
      elsif req.path =~ /search/
         search_term = req.params['q']
         resp.write handle_search(search_term)
      elsif req.path =~ /cart/
         if @@cart.empty?
            resp.write 'Your cart is empty'
         else
            @@cart.each do |item|
               resp.write "#{item}\n"
            end
         end
      elsif req.path =~ /add/
         search_term = req.params['item']
         resp.write handle_cart_inventory(search_term)
      else
         resp.write 'Path Not Found'
      end

      resp.finish
   end

   def handle_cart_inventory(search_term)
      if @@items.include?(search_term)
         @@cart.push(search_term)
         "added #{search_term}"
      else
         "We don't have that item"
      end
   end

   def handle_search(search_term)
      if @@items.include?(search_term)
         "#{search_term} is one of our items"
      else
         "Couldn't find #{search_term}"
      end
   end
end
