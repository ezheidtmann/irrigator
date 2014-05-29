require 'mongo'
require 'rgeo'
require 'pp'

include Mongo

mongo = MongoClient.new
db = mongo['irrigator']
stations = db['ghcnd_stations']

File.readlines("./ghcnd-stations.txt").each do |line|
  row = line.unpack('A12A9A10A7A3A31A4A4A6')
  obj = {
    :id => row[0].strip,
    :lat => row[1].to_f,
    :lng => row[2].to_f,
    :elevation => row[3].to_f,
    :state => row[4].strip,
    :name => row[5].strip,
    :gsnflag => (row[6].strip == 'GSN') ? 1 : 0,
    :hcnflag => (row[7].strip == 'HCN') ? 1 : 0,
    :wmoid => row[8].to_i,
  }

  obj['loc'] = {
    :type => 'Point',
    :coordinates => [ obj[:lng], obj[:lat] ],
  }
  p obj[:id]

  stations.update({ :id => obj[:id] }, obj, { :upsert => true })
end

