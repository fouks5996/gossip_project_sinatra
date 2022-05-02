require_relative 'gossip'

class ApplicationController < Sinatra::Base

   # création de la route accueil, qui parle au fichier index et qui récupère tous les gossips
   get '/' do
      erb :index, locals: {gossips: Gossip.all}
   end

   #création de la route /new, qui parle au fichier :new_gossip --> affiche le formulaire de publication
   get '/gossips/new/' do
      erb :new_gossip
   end

   # formulire en Post pour récuperer les infos du formulaire et les envoie au fichier csv avec Gossip.new.save
   post '/gossips/new/' do
      Gossip.new(params["gossip_author"], params["gossip_content"]).save  
      redirect '/'
   end

   #Création de la route DYNAMIQUE avec l'ID du potin grâce à la méthode Gossip.find
   get '/gossips/:id/' do
      erb :show, locals: {gossip: Gossip.find(params['id'])}
   end

   # Création de la route edit en fonction de l'ID 
   get '/gossips/:id/edit/' do
      erb :edit
      end

   # formulire en Post pour récuperer les infos du formulaire qui les envoie au fichier csv
   post '/gossips/:id/edit/' do
      Gossip.update(params['id'].to_i, params["gossip_author"], params["gossip_content"])
      redirect '/'
   end

end

#shotgun -p 4567