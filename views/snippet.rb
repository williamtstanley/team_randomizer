
names.split(",").shuffle


team_array = names.each_slice(number_of_teams).to_a
team_hash = {}
team_array.each_index do |index|
     team_hash[("Team" + (index+1).to_s).to_sym] = team_array[index]
end

