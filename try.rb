require 'rubygems'
require 'eventmachine'
require 'em-http'


require 'json'

class JSONify
  def response(resp)
    resp.response = JSON.parse(resp.response)
  end
end

EventMachine.run {
  api = EM::HttpRequest.new('http://www.ncdc.noaa.gov:80/cdo-web/api/v2/')
  api.use JSONify

  request_options = {
    :path => "/cdo-web/api/v2/data", 
    :query => { 
      'locationid' => 'ZIP:97211',
      'datasetid' => 'GHCND',
      'datatypeid' => 'PRCP',
      'startdate' => '2010-01-01',
      'enddate' => '2010-01-05',
    },
    :head => {
      'Token' => 'kCbjzgsMEDpHugAFXbBkvHSQkdmqZMHj'
    }
  }

  req = api.get request_options

  req.callback {
    p req.response_header
    p req.response

    EM.stop
  }
}
