require 'rails_helper'

RSpec.describe 'plots index' do 
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

    visit plots_path
  end  

  describe 'user story 1' do
    it 'displays list of all plot numbers' do
      expect(page).to have_content("Plot Number: #{@plot1.number}")
      expect(page).to have_content("Plot Number: #{@plot2.number}")
      expect(page).to have_content("Plot Number: #{@plot3.number}")
      expect(page).to have_content("Plot Number: #{@plot4.number}")
      expect(page).to have_content("Plants:")
      expect(page).to_not have_content("Plot Number: 444")
    end  
  
    it 'displays list the names of all that plots plants under each plot' do
      within "#plot_#{@plot1.id}_plants" do
        expect(page).to have_content("Plants: Purple Beauty Sweet Bell Pepper")
        expect(page).to have_content("Plants: Pumpkin")
        expect(page).to_not have_content("Plant: Cucumber")
      end
    end

    describe 'user story 2' do
      it 'displays link to remove that plant from that plot' do
        within "#plot_#{@plot1.id}_plants" do
        expect(page).to have_content("Plants: Pumpkin")
        expect(page).to have_content("Plants: Purple Beauty Sweet Bell Pepper")
       
        click_link("Remove Plant", match: :first)
        end
        
        expect(page).to_not have_content("Plant: Pumpkin")
        expect(current_path).to eq(plots_path)
      end
    end
  end  
end    
    # User Story 2, Remove a Plant from a Plot

# As a visitor
# When I visit the plots index page
# Next to each plant's name
# I see a link to remove that plant from that plot
# When I click on that link
# I'm returned to the plots index page
# And I no longer see that plant listed under that plot,
# And I still see that plant's name under other plots that is was associated with.

# Note: you do not need to test for any sad paths or implement any flash messages. 
# end    

