class Garden < ApplicationRecord
  has_many :plots
  has_many :plants_plot, through: :plots
  has_many :plants, through: :plots

  def plant_list
    plants.where("days_to_harvest <= 100").distinct
  end
end

