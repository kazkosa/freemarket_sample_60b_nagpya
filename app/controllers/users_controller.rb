class UsersController < ApplicationController
  def index
  end
  def card
    @user = User.new() #temporaly 
  end
  def logout
  end  
  def plofile
    #仮のモデル作成
    @user =User.new()
  end  
  def identification
    #仮のモデル作成
    @user =User.new()
  end  
end
