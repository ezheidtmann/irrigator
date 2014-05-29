require 'sinatra'
require 'sinatra/json'
require 'mongo'
require 'geocoder'
include Mongo

mongo = MongoClient.new
db = mongo['irrigator']
stations = db['ghcnd_stations']

# mongo indexes I should probably be running:
# db.ghcnd_stations.ensureIndex({ id: 1 }, {unique: true })
# db.ghcnd_stations.ensureIndex({ loc: "2dsphere" })

get '/' do
  erb :index, :locals => { 'location' => request.location }
end

get '/nearest.json' do
  lnglat = params[:lnglat].split(',').map(&:to_f)
  conditions = {
    '$near' => {
      '$geometry' => { 'type' => 'Point', 'coordinates' => lnglat },
      '$maxDistance' => 250000, # 250 km
    }
  }
  output = []
  stations.find({ 'loc' => conditions }, { :limit => 10 }).each do |doc|
    output.push(doc)
  end

  json output
end
