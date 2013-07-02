require File.join(File.dirname(__FILE__), 'app.rb')

parser = Parser.new('/Users/drodriguez/development/flatiron/sinatra/citibike-sinatra/data/station_data.json')
parser.call

run Citibike::App