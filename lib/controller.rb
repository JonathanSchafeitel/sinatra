# frozen_string_literal: true

require 'bundler'
Bundler.require

require 'gossip'

class ApplicationController < Sinatra::Base
  # Affiche la homepage et tous les potins, passe les objets Gossip de tous les potins
  get '/' do
    erb :index, locals: { gossips: Gossip.all }
  end
  # Route pour la page de création du new gossip
  get '/gossips/new/' do
    erb :new_gossip
  end
  # Création d'un nouveau gossip sur la base de donnée
  post '/gossips/new/' do
    Gossip.new(params['gossip_author'], params['gossip_content']).save
    redirect '/' # Redirige vers l'acceuil
  end
  # Affiche un potin de manière unique via son id
  get '/gossips/:id' do
    erb :show, locals: { id: params['id'].to_i, gossips: Gossip.find(params['id'].to_i) }
  end
  # Permet d'éditer avec le formualaire edit.erb
  get '/gossips/:id/edit' do
    erb :edit, locals: {id: params['id'].to_i, gossips: Gossip.find(params['id'].to_i)}
  end
  # Récupère la saisie dans le formualaire pour update le potin
  post '/gossips/edit/' do
    Gossip.update(params['id'].to_i, params['gossip_author'], params['gossip_content'])
    redirect '/'
  end
end
