require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plants), through: :plots }
  end

  before :each do 
    @garden1 = Garden.create!(name: "Turing Community Garden", organic: true)

    @plant1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
    @plant2 = Plant.create!(name: "Pumpkin", description: "Prefers hills, full sun.", days_to_harvest: 110)
    @plant3 = Plant.create!(name: "Carrot", description: "Too much water can cuase cracking.", days_to_harvest: 67)

    @plot1 = Plot.create!(number: 25, size: "Large", direction: "East", garden_id: @garden1.id) 
    @plot2 = Plot.create!(number: 42, size: "Large", direction: "West", garden_id: @garden1.id) 
    @plot3 = Plot.create!(number: 20, size: "Medium", direction: "North", garden_id: @garden1.id) 
    @plot4 = Plot.create!(number: 10, size: "Small", direction: "South", garden_id: @garden1.id) 

    PlantPlot.create!(plant_id: @plant1.id, plot_id: @plot1.id)
    PlantPlot.create!(plant_id: @plant2.id, plot_id: @plot1.id)
    PlantPlot.create!(plant_id: @plant3.id, plot_id: @plot2.id)
    PlantPlot.create!(plant_id: @plant3.id, plot_id: @plot3.id)
  end  

  it 'should includes plants that take less than 100 days to harvest' do
    expect(@garden1.plant_list).to eq([@plant1, @plant3])
  end
end  
