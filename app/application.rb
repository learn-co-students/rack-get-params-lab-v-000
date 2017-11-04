require 'pry'

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
      if @@cart == []
        resp.write "Your cart is empty"
      else
          @@cart.each do |item|
            resp.write "#{item}\n"
        end
      end
    elsif req.path.match(/add/)

      search_term = req.params["item"]
      resp.write handle_add_search(search_term)
    else
      resp.write "Path Not Found"
    end

    # if req.path.match(/cart/)
    #   @@cart.each do |item|
    #     resp.write "#{item}\n"
    #   end
    # elsif req.path.match(/search/)
    #   search_term = req.params["p"]
    #   resp.write handle_search(search_term)
    # else
    #   resp.write "That item is not found"
    # end


    resp.finish
  end


  def handle_search(search_term)
    if @@items.include?(search_term)

      if req.path.match(/add/)
        @@cart << search_term
        resp.write "added #{search_term}"
      end
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  def handle_add_search(search_term)
    if @@items.include?(search_term)
        @@cart << search_term
        return "added #{search_term}"
    else
        return "We don't have that item"
    end

  end

end
