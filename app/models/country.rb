class Country < ApplicationRecord
  has_many :regions, :dependent => :delete_all
end
