class UsersController < ApplicationController
  def index
  end
  def card
    @user = User.new() #temporaly 
  end
  def logout
  end
  
  def notification
    @notifications = [1] #nemporaly
  end
  
  def todo
    @todos = [1] #nemporaly
  end
  
  def like
    @likes = [1] #nemporaly
  end
  def plofile
    #仮のモデル作成
    @user =User.new()
  end  
end
