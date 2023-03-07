class PlantPlotsController < ApplicationController
  def destroy
    plant_plot = PlantPlot.find_by(
      plot: params[:plot_id],
      plant: params[:plant_id]
    )

    plant_plot.destroy

    redirect_to plots_path
  end
end