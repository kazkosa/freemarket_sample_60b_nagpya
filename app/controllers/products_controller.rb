class ProductsController < ApplicationController
  def index
   
  end  
  def sell
    @product= Product.new()
    @parent = Category.all.order("id ASC").limit(1)
    @children =@parent[0].children 
    @grandchildren = @children[0].children
  end 

  def create
    @product = Product.new(product_params)
    if @product.save
      product_image_params[:images].each do |image|
        @product.product_images.build
        product_image = @product.product_images.new(image: image)
        product_image.save
      end
      respond_to do |format|
        format.json
      end
    else
      render "/products/sell" unless @product.valid?
    end
  end
  
  private
  def product_params
      params.require(:product).permit(:title, :description, :category_id, :size, :brand_id, :condition, :shipping_charges, :shipping_area, :shipping_method, :shipping_date, :price).merge(user_id:current_user.id)
  end
  def product_image_params
    #imageのストロングパラメータの設定.js側でimagesをrequireすれば画像のみを引き出せるように設定する。
    params.require(:image).permit({images:[]})
  end
  def show
  end
  def buy
  end
end