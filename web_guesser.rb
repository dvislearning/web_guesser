require 'sinatra'
require 'sinatra/reloader'

enable :sessions


#A random amount of guesses allowed is generated each time.
#I wanted to make it feel a bit like a casino game.



get '/' do
	new_game if session[:number].nil?
	session[:cheat] =  params["cheat"]

	erb :index
end


post '/process' do
	session[:correct] = false
	session[:end_game_message] = nil
	@guess = params["guess"] =~ /\d+/ ? params["guess"].to_i : params["guess"]

	guess_check
	track_guesses


	redirect to ('/')
end


helpers do
	def new_game
		session[:number] = rand(99) + 1
		session[:guesses] = rand(3..8)
	end

	def track_guesses
		if session[:correct] == true
			session[:end_game_message] = "You are a master guesser! <br><br> Starting New Game <br>Generating new number and amount of guesses."
			new_game
		elsif session[:correct] ==  false && session[:guesses] > 1
			session[:guesses] -= 1
		elsif session[:correct] == false && session[:guesses] <= 1
			session[:end_game_message] = "You lost. <br><br> Starting New Game - Generating new number and amount of guesses."
			new_game
		end
	end

	def guess_check
		if !((0...100) === @guess)
			session[:message] = "Please select a number between 1 and 99"
			session[:bg_color] = "grey" 
		elsif @guess > session[:number] + 10
			session[:message] = "Your guess is WAY too high."
			session[:bg_color] = "red"			
		elsif @guess > session[:number] && @guess <= session[:number] + 10
			session[:message] = "Your guess is too high."
			session[:bg_color] = "#ff3232"			
		elsif @guess < session[:number] - 10
			session[:message] = "Your guess is WAY too low."
			session[:bg_color] = "red"			
		elsif @guess < session[:number] && @guess >= session[:number] - 10
			session[:message] = "Your guess is too low."
			session[:bg_color] = "#ff3232"				
		elsif @guess ==  session[:number]
			session[:correct] = true
			session[:message] = "Your guess is correct! <br> The number was #{session[:number]}"
			session[:bg_color] = "green"			
		end
	end
end