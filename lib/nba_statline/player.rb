class NbaStatline::Player
  attr_accessor :name, :team, :conference, :position, :number, :url

  @@all = []

  def initialize

  end


  def self.create_from_data(player)
    
    #doc.search("td.sortcell a").each do |player|
      new_player = NbaStatline::Player.new
      new_player.name = player.children[1].children[0].children[0].text
      
      new_player.url = player['href']
      @@all << new_player
      new_player
       
  end 

  def add_player_info
    doc = Nokogiri::HTML(open(self.url))
    
      self.number = doc.search("ul.general-info li").first.text.match(/\d+/)
      self.position = doc.search("ul.general-info li").first.text.match(/[A-Z]+/)
        
  end

  def self.list_players
    @@all.each do |player|
      puts player.name
    end
  end

end