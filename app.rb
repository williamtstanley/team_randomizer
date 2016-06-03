require 'sinatra'
require 'sinatra/reloader'
require 'pry'

enable :sessions
use Rack::MethodOverride

before do
    session[:team_hash] = {} unless session[:team_hash]
end



get "/" do
    @title = "Team Randomizer"
    erb :index, layout: :app_layout
end


post "/" do
    @title = "Team Randomizer"
# CODE GOES HERE ------------------- #
    # {"names"=>"travis,william,another,thingy", "method"=>"team_count", "num"=>"this", "button"=>"Submit"}
    @names = params[:names]
    @method = params[:method]
    @number = params[:number].to_i
    @names_array = @names.split(",").shuffle
    session[:team_hash] = {}
    if @method == "team_count"
        @number_of_teams = @names_array.length / @number
    else
        @number_of_teams = @number
    end


    team_array = @names_array.each_slice(@number_of_teams).to_a
    team_array.each_index do |index|
         session[:team_hash][("Team " + (index+1).to_s).to_sym] = team_array[index]
    end
    puts params
    redirect to ("/")
end




