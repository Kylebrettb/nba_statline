class Nbastatline::CLI

def call
  Nbastatline::Team.create_teams if Nbastatline::Team.all.empty?
  
  puts "Welcome to NBA Statline!"
  
  puts "Please enter the number for a team to see its players or type 31 to exit"
  Nbastatline::Team.list_teams
  puts "31. Exit!!!"

  input = gets.chomp.to_i
   if input == 31
    puts "Goodbye!"
  elsif (1..30).include?(input)
    team = Nbastatline::Team.find_team(input)
    team.create_players_from_team
    puts "The players of the #{team.name}"
     team.list_players
     continue?
  else
      puts "I am sorry please enter a valid team number"

    
  end
   
end

def continue?
  puts "Would you like to look at another team? Yes to return or No to exit."
    input = gets.chomp
    if input.downcase.capitalize == "Yes"
      call
    else
      puts "Goodbye!"
    end
  end

end