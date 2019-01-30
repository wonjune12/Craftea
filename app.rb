require "sinatra"
require "sendgrid-ruby"
require_relative "/cake"
require_relative "/cookie"
require_relative "/muffin"
include SendGrid 


get "/" do
  erb(:home)
  
end

get "/cookies" do
  @cookiearray = []
  @chocolatechip = Cookie.new("Chocolate chip cookie", "$8.99 per lb", "chocolatechipcookie.jpeg")
  @sugar = Cookie.new("sugar cookie", "$6.99 per lb", "sugarcookies.jpg")
  @oatmeal = Cookie.new("Oatmeal Raisin   Cookie", "6.99 per lb", "oatmealcookies.jpeg")
  @cookiearray.push(@chocolatechip)
  @cookiearray.push(@sugar)
  @cookiearray.push(@oatmeal)
  erb(:cookies)
end


get "/cakes" do
  @cakearray = []
  @cheesecake = Cake.new("Strawberry Cheesecake", "$25.00", "cheesecake.jpg")
  @shortcake = Cake.new("Strawberry Shortcake", "$25.00", "shortcake.png")
  @sweetpotatocake = Cake.new("Sweet Potato Cake", "$30.00", "sweetpotatocake.jpeg")
  @cakearray.push(@sweetpotatocake)
  @cakearray.push(@cheesecake)
  @cakearray.push(@shortcake)
  erb(:cakes)
end

get "/muffins" do
  @muffinarray = []
  @poppylemon = Muffin.new("Lemon Poppyseed Muffin", "$2.50 each", "lemonpoppyseedmuffin.png")
  @cornmuffin = Muffin.new("Corn Muffin", "$2.50 each", "cornmuffin.jpeg")
  @blueberrymuffin = Muffin.new("Blueberry Muffin", "$2.50 each", "blueberryMuffins.jpeg")
  @muffinarray.push(@blueberrymuffin)
  @muffinarray.push(@poppylemon)
  @muffinarray.push(@cornmuffin)
  erb(:muffins)
end

get "/catalog" do
  erb(:catalog)

  end


post "/catalogsent" do

  from = SendGrid::Email.new(email:"wonjune12@gmail.com")
  to = SendGrid::Email.new(email:params[:to])
  subject = "Bakery Catalog!"
  content = SendGrid::Content.new( 
  type: 'text/html', 
  value: "cookies  : #{@cookiearray}
          muffins  : #{@muffinarray}
          cakes  : #{@muffinarray}"
  )
  


  mail = SendGrid::Mail.new(from, subject, to, content)
  sg = SendGrid::API.new()
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  
  response.status_code
  
  
end


