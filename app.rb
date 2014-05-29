require 'sinatra'
require 'sinatra/json'
require 'mongo'
require 'geocoder'
include Mongo

mongo = MongoClient.new
db = mongo['irrigator']
stations = db['ghcnd_stations']
geocodes = db['geocode_cache']

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
  json stations.find({ :loc => conditions }, { :limit => 10 }).to_a
end

get '/geocode.json' do
  addr = params[:addr].strip
  output = geocodes.find_one :addr => addr
  if ! output
    output = { :addr => addr }
    results = Geocoder.search addr
    if results[0].nil?
      output[:error] = true,
      output[:userMessage] = 'Geocoding failed'
    else
      output[:lat] = results[0].latitude
      output[:lng] = results[0].longitude
      output[:precision] = results[0].precision
      geocodes.insert(output)
    end
  end

  # TODO: exclude "_id" parameter
  json output
end

get 'precip.json' do
  station = params[:station]
  # TODO: query CDO api for specified station, return json

  json output
end

