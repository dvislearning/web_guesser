require 'sinatra'
require 'sinatra/reloader'


#A random amount of guesses allowed is generated each time.
#I wanted to make it feel a bit like a casino game.

@@number = rand(100)
@@correct = false
@@guesses = rand(8) + 1

get '/' do
	guess = params["guess"].to_i
	cheat_mode = params["cheat"]
	message, background_color = guess_check(guess, @@number)
	guess_status = track_guesses

	erb :index, :locals => {:number => @@number, :message => message, :background_color => background_color, :guess_status => guess_status, :guesses => @@guesses, :cheat_mode => cheat_mode}
end


def track_guesses
	if @@correct == true
		@@number = rand(100)
		@@guesses = rand(8) + 1
		@@correct = false
		"You are a master guesser! <br><br> Starting New Game - <br>Generating new number and amount of guesses."
	elsif @@correct ==  false && @@guesses > 1
		@@guesses -= 1
		""
	elsif @@correct == false && @@guesses <= 1
		@@number = rand(100)
		@@guesses = rand(8) + 1
		@@correct = false
		"You lost. <br><br> Starting New Game - <br>Generating new number and amount of guesses."
	end
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
		@@correct = true
		["Your guess is correct! <br> The number was #{number}", "green"]
	end
end



#Sinatra/reloader gem allows you to reload your page with changes without
#having to reload the server.