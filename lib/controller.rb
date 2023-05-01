require 'gossip'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/:id' do
    @gossip = Gossip.find(params[:id])
    @id = params[:id].to_i+1
    erb :gossip_show
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params[:gossip_author], params[:gossip_content]).save
    redirect '/'
  end

  get '/gossips/:id/edit/' do
    @gossip = Gossip.find(params[:id].to_i-1)
    @id = params[:id]
    erb :edit
  end

  post '/gossips/:id/edit' do
    @id = params[:id].to_i
    Gossip.update(@id, params[:gossip_author], params[:gossip_content])
    redirect '/'
  end

end