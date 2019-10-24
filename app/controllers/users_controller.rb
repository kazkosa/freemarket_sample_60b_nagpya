class UsersController < ApplicationController
  def index
  end

  def show
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
  def identification
    #仮のモデル作成
    @user =User.new()
  end 

  def showedit
    @products=current_user.selling_products
  end 
end
