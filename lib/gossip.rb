class Gossip
  attr_accessor :author, :content

  def initialize(author_to_save, content_to_save)
    @author = author_to_save
    @content = content_to_save
  end

  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each_with_index do |csv_line, index|
      all_gossips << Gossip.new(csv_line[1], csv_line[2])
    end
    return all_gossips
  end

  def self.find(id)
    all_gossips = CSV.read("./db/gossip.csv")
    all_gossips.each do |csv_line|
      if csv_line[0].to_i-1 == id.to_i
        return Gossip.new(csv_line[1], csv_line[2])
      end
    end
    return nil # renvoie nil si le potin n'est pas trouvé
  end  

  def save
    all_gossips = CSV.read("./db/gossip.csv")
    last_id = all_gossips.empty? ? 0 : all_gossips.last[0].to_i
    new_id = last_id + 1
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [new_id, author, content]
    end
  end

  def self.update(id, gossip_author, gossip_content)
    all_gossips = CSV.read("./db/gossip.csv")
    all_gossips.each_with_index do |row, index|
      if index == id.to_i-1
        row[1] = gossip_author
        row[2] = gossip_content
      end
    end
    CSV.open("./db/gossip.csv", "w") do |csv|
      all_gossips.each do |row|
        csv << row
      end
    end
  end  
end
