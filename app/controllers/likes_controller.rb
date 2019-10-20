class LikesController < ApplicationController
  def create
    @like = Like.find_by(user_id: current_user.id, product_id: params[:product_id])
    @like = Like.create(user_id: current_user.id, product_id: params[:product_id]) unless @like
    @product = Product.find_by(id: @like.product_id)
    @like_count = Like.where(product_id: params[:product_id]).count
  end 
  def destroy
    @like = Like.find_by(user_id: current_user.id, product_id: params[:product_id])
    @product = Product.find_by(id: @like.product_id)
    @like.destroy if @like
    @like_count = Like.where(product_id: params[:product_id]).count
  end
end
