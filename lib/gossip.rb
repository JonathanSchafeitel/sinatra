# frozen_string_literal: true

require 'bundler'
Bundler.require

class Gossip
  attr_accessor :gossip_author, :gossip_content

  def initialize(gossip_author, gossip_content)
    @gossip_content = gossip_content
    @gossip_author = gossip_author
  end

  def save
    CSV.open('db/gossip.csv', 'a') do |csv|
      csv << [@gossip_author, @gossip_content]
    end
  end

  def self.all
    all_gossips = []
    CSV.read('./db/gossip.csv').each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    all_gossips
  end

  def self.find(id)
    gossips = [] # permet de stocker la ligne csv demandée
    CSV.read('./db/gossip.csv').each_with_index do |row, index|
      if id == index + 1 # cherche et check si l'index est égale id demandé
        gossips << Gossip.new(row[0], row[1]) # si trouvé, ajout dans array et break pour retourner l'array
        break
      end
    end
    gossips
  end

  def self.find(id)
    gossips = [] # permet de stocker la ligne csv demandée
    CSV.read('./db/gossip.csv').each_with_index do |row, index|
      if id == index + 1 # cherche et check si l'index est égale id demandé
        gossips << Gossip.new(row[0], row[1]) # si trouvé, ajout dans array et break pour retourner l'array
        break
      end
    end
    gossips
  end

  def self.update(id, author, content)
    gossips = []

    # recréé l'arrayt et csv avec les données modifiées.
    CSV.read('./db/gossip.csv').each_with_index do |row, index|
      gossips << if id.to_i == (index + 1)    # i
                   [author, content]
                 else
                   [row[0], row[1]]
                 end
    end

    CSV.open('./db/gossip.csv', 'w') do |csv|
      gossips.each do |row|
        csv << row
      end
    end
  end
end
