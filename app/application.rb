class Application
  def call(env)
    resp=Rack::Response.new
    req = Rack::Request.new(env)
    # Your application should only accept the /items/<ITEM NAME> route. Everything else should 404
    if req.path.match("/items/")
      item_requested=req.path.split("/items/").last
      # puts "*******#{item_requested}"
      # If a user requests /items/<Item Name> it should return the price of that item
      price = self.item_check(item_requested)
      # puts "*********#{price}"
      # puts "*****ITEMS.ALL = #{Item.all}"
      if price #is not nil
        resp.write price
      # IF a user requests an item that you don't have, then return a 400 and an error message
      else
        resp.write    "Item not found"
        resp.status = 400
      end
      # resp.write "You requested items"
    else
      resp.write "Route not found"
      resp.status= 404
    end
    resp.finish
  end #call

  def item_check(item_requested)
    #ex Figs
    items=Item.all
    price = nil
    items.each do |item|
      price = item.price if item_requested == item.name
    end
    price
  end

end #class
