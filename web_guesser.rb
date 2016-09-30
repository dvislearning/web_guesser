require 'sinatra'
require 'sinatra/reloader'

number = rand(101)

get '/' do
	erb :index, :locals => {:number => number}
end

#Sinatra/reloader gem allows you to reload your page with changes without
#having to reload the server.