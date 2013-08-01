require "csv"
require "date"
def band_infos
  dirname = File.dirname(__FILE__)
  csv_data = CSV.read "#{dirname}/shot_formoz.csv"

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

  bands
end

def convert_time_to_db_format original
  t = DateTime.strptime(original, "%m/%d/%Y %T")  
  t.strftime("%Y-%m-%d %T")
end

namespace :shot do
  task :import_band => :environment do
    Band.destroy_all

    band_infos.each do |b|
      Band.create({
        :name => b["name"],
        :stage => b["stage"],
        :start_time => convert_time_to_db_format(b["start_time"]),
        :end_time => convert_time_to_db_format(b["end_time"]),
        :photo_url => b["photo_url"]
      })
    end
  end
end
