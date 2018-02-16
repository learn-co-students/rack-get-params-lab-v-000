class Application
#=================================================
  attr_accessor :resp
  @@items = ["Apples","Carrots","Pears"]
  @@cart = []
#====================Response=====================
  def call(env)
    self.resp = Rack::Response.new
    req = Rack::Request.new(env)
#---------------------Routes----------------------
    # items
    if req.path.match(/items/)
      display_items
    
    # cart
    elsif req.path.match(/cart/)
      display_cart
    
    # search
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      handle_search(search_term)
    
    # add to cart
    elsif req.path.match(/add/)
      item = req.params["item"]
      add_to_cart(item)
    
    # not found
    else
      write "Path Not Found"
    end
#-------------------------------------------------
    resp.finish
  end
#=================================================
  
  
#====================Helpers======================
  # write
  def write(this)
    resp.write this
  end
  
  # items
  def display_items
    @@items.each{|item| write "#{item}\n" }
  end
  
  # cart
  def display_cart
    if @@cart.empty? then write "Your cart is empty" else write @@cart.join("\n") end
  end
  
  # search
  def handle_search(search_term)
    includes = @@items.include?(search_term)
    write "#{search_term} is one of our items" if includes
    write "Couldn't find #{search_term}" if !includes
  end
  
  # add to cart
  def add_to_cart(item)
    includes = @@items.include?(item)
    @@cart << item and write "added #{item}" if includes
    write "We don't have that item" if !includes
  end
#=================================================
end
