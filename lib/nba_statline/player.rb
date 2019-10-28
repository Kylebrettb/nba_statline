class NbaStatline::Player
  attr_accessor :name, :team, :conference, :position, :number, :url

  @@all = []

  def initialize

  end


  def self.create_from_data(player)
    
    #doc.search("td.sortcell a").each do |player|
      new_player = NbaStatline::Player.new
      new_player.name = player.children[1].children[0].children[0].text
      
      new_player.url = player.children[1].children[0].children[0]["href"]
      @@all << new_player
      new_player
       
  end 

  def add_player_info
    doc = Nokogiri::HTML(open(self.url))
    
      self.number = doc.search("ul.PlayerHeader__Team_Info").children[1].text
      self.position = doc.search("ul.PlayerHeader__Team_Info").children[2].text
        
  end

  def self.list_players
    @@all.each do |player|
      puts player.name
    end
  end

end