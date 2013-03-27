class Tweet < ActiveRecord::Base
  # Remember to create a migration!
  def info
    "#{self.id}: #{self.content}"
  end  
end
