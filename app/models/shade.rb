class Shade < ActiveRecord::Base
  has_and_belongs_to_many :materials
end
