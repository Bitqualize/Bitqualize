require File.expand_path('../application', __FILE__)
Bitqualize::Application.initialize!
CACHE = Dalli::Client.new('localhost:11211')