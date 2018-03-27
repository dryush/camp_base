class City < ApplicationRecord
  belongs_to :region
  has_many :camps, :dependent => :delete_all
end
