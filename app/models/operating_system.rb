class OperatingSystem < ActiveRecord::Base
  has_many :instances
  has_many :os_vendors
end
