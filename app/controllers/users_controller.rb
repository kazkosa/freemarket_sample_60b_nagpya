class UsersController < ApplicationController
  def index
  end  
  
  def logout
  end  
  
  def plofile
    #仮のモデル作成
    @user =User.new()
  end  
end
