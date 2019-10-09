class UsersController < ApplicationController
  def card
    @user = User.new() #temporaly 
  end
end
