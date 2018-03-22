class City < ApplicationRecord
  belongs_to :region
  has_many :camps
end
