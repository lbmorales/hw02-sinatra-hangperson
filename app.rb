require 'sinatra/base'
require 'sinatra/flash'
require './lib/hangperson_game.rb'

class HangpersonApp < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  before do
    @game = session[:game] || HangpersonGame.new('')
  end

  after do
    session[:game] = @game
  end

  get '/' do
    redirect '/new'
  end

  get '/new' do
    erb :new
  end

  post '/create' do
    # NOTE: don't change next line - it's needed by autograder!
    word = params[:word] || HangpersonGame.get_random_word

    @game = HangpersonGame.new(word)
    redirect '/show'
  end

  post '/guess' do
    letter = params[:guess].to_s[0]
    begin
      if @game.guess(letter) == false
        flash[:message] = 'You have already used that letter.'
      end
    rescue ArgumentError
      flash[:message] = 'Invalid guess.'
    end
    redirect '/show'
  end

  # Everytime a guess is made, we should eventually end up at this route.
  # won, lost, or neither, and take the appropriate action.
  get '/show' do
    case @game.check_win_or_lose
    when :win then redirect '/win'
    when :lose then redirect '/lose'
    else
      erb :show
    end
  end

  get '/win' do
    if @game.word.empty?
      redirect '/new'
    elsif @game.check_win_or_lose != :win
      redirect '/show'
    else
      erb :win
    end
  end

  get '/lose' do
    if @game.word.empty?
      redirect '/new'
    elsif @game.check_win_or_lose != :lose
      redirect '/show'
    else
      erb :lose
    end
  end
end
