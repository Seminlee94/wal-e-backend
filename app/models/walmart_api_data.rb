require 'pry'
require 'json'
require "uri"
require "net/http"

# url = URI("https://api.wegmans.io/products/search?query=Milk&api-version=2018-10-18&") # item names (need to collect SKU)
# url = URI("https://api.wegmans.io/products/756505/prices?api-version=2018-10-18") # prices (interpolate SKU here)
url = URI("https://api.wegmans.io/products/756507?api-version=2018-10-18") # info - description & nutrients (interpolate SKU here)

https = Net::HTTP.new(url.host, url.port);
https.use_ssl = true

request = Net::HTTP::Get.new(url)
request["Subscription-Key"] = "c455d00cb0f64e238a5282d75921f27e"

response = https.request(request)
data = response.read_body

parse = JSON.parse(data)

binding.pry
0

# Your-Subscription-Key     fd14fe55ecb1449b97ebe48d34fd0749
# Secondary-Key     1383ace8eb374fdc8b8ced09f825f053
# WEGMAN         c455d00cb0f64e238a5282d75921f27e