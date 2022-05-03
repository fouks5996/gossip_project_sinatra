class Gossip
   attr_accessor :author, :content, :all_gossips, :tag

   def initialize(author, content, tag)
      @author = author
      @content = content
      @tag = tag
   end

   # sauvegarde des potins dans le fichier CSV
   def save
      CSV.open("./db/gossip.csv", "ab") do |csv|
         csv << [@author, @content, @tag]
       end
   end

   # Récupération des éléments du CSV pushés dans un tableau
   def self.all
      all_gossips = []
      CSV.read("./db/gossip.csv").each do |ligne|
         all_gossips << Gossip.new(ligne[0], ligne[1], ligne[2])
      end
      return all_gossips
   end

   # récupération de l'index en fonction du précédant tableau
   def self.find(id)
      all_gossips = self.all
      id = id.to_i
      id = id - 1
      return all_gossips[id]
   end

   # Modification, en fonction de l'index, de l'auteur et du contenu
    def self.update(id, new_author, new_content, new_tag)
      gossips = CSV.read("./db/gossip.csv")
      gossips[id - 1][0] = new_author
      gossips[id - 1][1] = new_content
      gossips[id - 1][2] = new_tag
      CSV.open("./db/gossip.csv", "w+") do |csv|
        gossips.each do |gossip|
          csv << gossip
        end
      end
    end
end