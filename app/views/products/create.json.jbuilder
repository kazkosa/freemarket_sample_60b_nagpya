json.product_id                       @product.id                                           if @product.id.present?
json.product_image_errors_image       !@product.product_images.present?                     unless params[:product_images].present?
json.product_errors_title             @product.errors.messages[:title].present?             unless @product.valid?
json.product_errors_description       @product.errors.messages[:description].present?       unless @product.valid?
json.product_errors_category_id       @product.errors.messages[:category_id].present?       unless @product.valid?
json.product_errors_size              @product.errors.messages[:size].present?              unless @product.valid?
json.product_errors_condition         @product.errors.messages[:condition].present?         unless @product.valid?
json.product_errors_shipping_charges  @product.errors.messages[:shipping_charges].present?  unless @product.valid?
json.product_errors_shipping_method   @product.errors.messages[:shipping_method].present?   unless @product.valid?
json.product_errors_shipping_area     @product.errors.messages[:shipping_area].present?      unless @product.valid?
json.product_errors_shipping_date     @product.errors.messages[:shipping_date].present?     unless @product.valid?
json.product_errors_price             @product.errors.messages[:price].present?             unless @product.valid?

