require "csv"
require "pp"
require "mysql2"

csv_data = CSV.read "shot_formoz.csv"

# get band data
bands = []
header = csv_data[0]
csv_data[1..-1].each do |data|
  band = {}
  header.each_with_index do |header_key, index|
    band[header_key] = data[index]
  end

  bands << band
end

client = Mysql2::Client.new({
  :username => 
  :password => 
  :host => "localhost",
  :database => "shot",
  :encoding => "utf8"
})

client.query("truncate table bands")

bands.each do |b|
  client.query("insert into bands (name, stage, start_time, end_time, photo_url) " +
               "values ( '#{b["name"]}', '#{b["stage"]}', '#{b["start_time"]}', " +
               "'#{b["end_time"]}', '#{b["photo_url"]}' )")
end
