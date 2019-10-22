class TrialsController < ApplicationController
  def index
    @trials = Trial.order('id DESC')
    @trial = Trial.new()
  end
  def new
    @trial = Trial.new()
  end
  def create
    @trial=Trial.new(trial_params)
    binding.pry
    # @trial.save

    redirect_to "/trials"
  end

  def edit
    # binding.pry
    @trial=Trial.find(params[:id])
    @trial.image.cache!
  end
  def update
    binding.pry
    @trial=Trial.find(params[:id])
    @trial.update(trial_params)

    redirect_to "/trials"
 
  end
  private
  def trial_params
   params.require(:trial).permit(:image,:image_cache)
    # params.permit(:image)
  end
end
