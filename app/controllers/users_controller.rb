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
    @products=current_user.selling_products.where(state: ['in_sales' ,'pending']).order("id DESC")
  end 
  def show_transaction
    @products=current_user.sold_products.where(state: ['waiting_for_shipping', 'on_delivery' ,'arrived']).order("id DESC")
  end
  def show_completed
    @products=current_user.sold_products.where(state: 'completed' ).order("id DESC")
  end

  def purchase
    @products=current_user.sold_products.where(state: ['waiting_for_shipping', 'on_delivery', 'arrived']).order("id DESC")
  end
  def purchased
    @products=current_user.sold_products.where(state: 'completed' ).order("id DESC")
  end

end
