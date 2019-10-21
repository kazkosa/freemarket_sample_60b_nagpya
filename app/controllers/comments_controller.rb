class CommentsController < ApplicationController
  def new
  end
  def create
    @product = Product.find(params[:product_id])
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html {redirect_to product_path(@product), notice:"commented"}
        format.json
      else
        format.html {redirect_to product_path(@product), notice:"Comment rejected"}
        format.json
      end
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id, product_id: params[:product_id])
  end
end
