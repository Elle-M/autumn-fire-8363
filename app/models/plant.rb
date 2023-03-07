class Plant < ApplicationRecord
  has_many :plant_plots
  has_many :plants, through: :plant_plots
end
