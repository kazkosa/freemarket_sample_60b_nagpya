class UsersController < ApplicationController
  def index
  end
  def card
    @user = User.new() #temporaly 
  end
  def logout
  end  
end