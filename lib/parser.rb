
class Parser
  def initialize(dir_name)
    @dir_name = dir_name
  end

  def call
    json = File.open(@dir_name).read
    stations = MultiJson.load(json)
    stations["stationBeanList"].each do |station|

      Station.create(station)

    end
  end
end
