require 'sinatra'
set :protection, except: :ip_spoofing

get '/' do
  return 'Hello, World. Sinatra!'
end
