require 'sinatra'
require 'sinatra/reloader'

get '/' do
	random_number = rand(101)
	'The SECRET NUMBER is ' + random_number.to_s
end

#Sinatra/reloader gem allows you to reload your page with changes without
#having to reload the server.