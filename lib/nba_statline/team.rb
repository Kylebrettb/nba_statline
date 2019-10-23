require "open-uri"
require "nokogiri"
class NbaStatline::Team
  attr_accessor :name, :conference, :players, :url

  @@all = []

  def initialize
    @players = []
  end


  def self.create_teams
    doc = Nokogiri::HTML(open("https://espn.com/nba/teams"))
    doc.search("div.pl3").each do |team| 
      new_team = NbaStatline::Team.new
      new_team.name = team.children.first.text
      new_team.url = team.children.first["href"]
      @@all << new_team
    end

  end

  def list_players
    puts "Name|Number|Position"
    self.players.each do |player|
      puts "#{player.name}|#{player.number}|#{player.position}"
    end
  end

  def self.find_team(input)
    team = @@all[input-1]
    team
  end

  def self.list_teams
    @@all.each_with_index do |team, index|
      puts "#{index + 1}. #{team.name}"
    end
  end

  def self.all
    @@all
  end


  def create_players_from_team
    self.url = self.format_team_url
      
      doc = Nokogiri::HTML(open(self.url))
      doc.search("td.sortcell a").each do |player|
      new_player = NbaStatline::Player.create_from_data(player)
      
      new_player.add_player_info
      new_player.team = self
      
      self.players << new_player
      end

  end

  def format_team_url
    split_array = self.url.split("/")
    new_array = []
    split_array.each do |text|
      if text == "_"
        text = "roster"
        new_array << text
      else 
        new_array << text
      end
    end
    new_array.pop
    new_array.insert(6,"_")
    new_array.join("/")
  end
end