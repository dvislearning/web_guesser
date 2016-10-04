require 'sinatra'
require 'sinatra/reloader'

number = rand(100)

get '/' do
	guess = params["guess"].to_i
	message, background_color = guess_check(guess, number)
	erb :index, :locals => {:number => number, :message => message, :background_color => background_color}
end

def guess_check(guess, number)
	return ["", "white"] if guess == 0
	if !((0...100) === guess)
		["Please select a number between 1 and 99", "grey"]
	elsif guess > number + 10
		["Your guess is WAY too high.", "red"]
	elsif guess > number && guess <= number + 10
		["Your number is too high", "#ff3232"]
	elsif guess < number - 10
		["Your guess is WAY too low.", "red"]
	elsif guess < number && guess >= number - 10
		["Your guess is too low.", "#ff3232"]
	elsif guess ==  number
		["Your guess is correct.", "green"]
	end
end




#Sinatra/reloader gem allows you to reload your page with changes without
#having to reload the server.