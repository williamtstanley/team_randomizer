require 'rubygems'
require 'bundler/setup'

require 'sinatra'
# require 'sinatra/reloader'


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
    @names = params[:names]
    @method = params[:method]
    @number = params[:number].to_i
    @names_array = @names.split(",").shuffle
    if @names != "" && @number != 0 && @number < @names_array.length
        if @method == "team_count"
            @number_of_teams = @number
        else
            @number_of_teams = @names_array.length / @number
        end
        #hash of teams with empty arrays
        team_hash = ((1..@number_of_teams).map {|num| ("team" + num.to_s).to_sym}).each_with_object({}){|key, hash| hash[key] = []}
        #push 0th member to array and delete from array
        ((@names_array.length / @number_of_teams) + 1).times do
            team_hash.each_key do |key|
                (team_hash[key] << @names_array.delete_at(0))
                team_hash[key].compact!
            end
            session[:team_hash] = team_hash
        end

    end
    redirect to ("/")
end




