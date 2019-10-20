json.body         @comment.body
json.created_at   @comment.created_at.to_s if @comment.created_at.present?
json.user_name    @comment.user.nickname
json.seller       true  if @comment.user_id == @product.user_id
