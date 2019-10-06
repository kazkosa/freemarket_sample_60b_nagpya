class TrialsController < ApplicationController
  def index
    @trials = Trial.order('id DESC')
    @trial = Trial.new()
  end
  def new
    #binding.pry
    @trial = Trial.new()
  end
  def create
    
    @trial=Trial.new(trial_params)
    binding.pry
    @trial.save

    redirect_to root_path
  end
  def update
    @trial=Trial.new(trial_params)
    redirect_to root_path
  end
  private
  def trial_params
    # binding.pry
   params.require(:trial).permit(:image)
    # params.permit(:image)
  end
end
