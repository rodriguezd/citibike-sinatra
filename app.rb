require 'rubygems'
require 'bundler'
require 'debugger'

Bundler.require

Dir.glob('./lib/*.rb') do |model|
  require model
end

DataMapper.setup(:default, "sqlite://#{Dir.pwd}/stations.db")
DataMapper.auto_migrate!

module Citibike
	class App < Sinatra::Application
    # before do
    #   json = File.open("data/citibikenyc.json").read
    #   @data = MultiJson.load(json)
    # end

    # get '/' do
    #   erb :home
    # end

    # get '/form' do
    #   erb :form
    # end

    # post '/form' do
    #   @start = params[:start]
    #   @end = params[:end]
    #   erb :form
    # end

    # post '/map' do
    #   @start = params[:start]
    #   @end = params[:end]
    #   erb :map
    # end

    get '/stations' do
      @stations = Station.all
      erb :index
    end

    get '/stations/new' do
      @station = Station.new
      erb :new
    end

    post '/stations' do
      @station = Station.new(params[:station])
      if @station.save
        status 201
        redirect'/stations/' + @station.id.to_s
      else
        status 400
        erb :new
      end
    end

    get '/stations/edit/:id' do
      @station = Station.get(params[:id])
      erb :edit
    end

    post '/stations/:id' do
      @station = Station.get(params[:id])
      if @station.update(params[:station])
        status 201
        redirect'/stations/' + params[:id]
      else
        status 400
        erb :edit
      end
    end

    get '/stations/delete/:id' do
      @station = Station.get(params[:id])
      erb :delete
    end

    delete '/stations/:id' do
      Station.get(params[:id]).destroy
      redirect '/stations'
    end

    get '/stations/:id' do
      @station = Station.get(params[:id])
      erb :show
    end

  end
end