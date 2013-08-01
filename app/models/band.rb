class Band < ActiveRecord::Base
  attr_accessible :end_time, :name, :stage, :start_time, :photo_url

  def as_json options = {}
    {
      :id => id,
      :name => name,
      :stage => stage,
      :start_time => start_time - 8.hour,
      :end_time => end_time - 8.hour,
      :photo_url => photo_url
    }
  end
end
