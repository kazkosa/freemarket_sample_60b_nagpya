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
    redirect_to "/trials"
  end

  def edit
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
  end
end
