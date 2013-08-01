require "csv"
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

namespace :shot do
  task :import_band => :environment do
    Band.destroy_all

    band_infos.each do |b|
      Band.create({
        :name => b["name"],
        :stage => b["stage"],
        :start_time => b["start_time"],
        :end_time => b["end_time"],
        :photo_url => b["photo_url"]
      })
    end
  end
end
