class ProductsController < ApplicationController
  def index
  end  
  def sell
      #仮のモデル作成
      @user =User.new()    
  end  
end
