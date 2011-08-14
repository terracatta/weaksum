class Instance < ActiveRecord::Base
  belongs_to :item
  belongs_to :operating_system
end
