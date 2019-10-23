class ProductsController < ApplicationController
  def index 
  end

  def sell
    @product= Product.new()
    @parent = Category.order("id ASC").limit(1)
    @children =@parent[0].children 
    @grandchildren = @children[0].children
    @product.product_images.build
  end 

  def create
    @product = Product.new(product_params)
    if params[:image].present? && @product.save
      product_image_params[:images].each do |image|
        @product.product_images.build
        product_image = @product.product_images.new(image: image)
        product_image.save
      end
    end
    respond_to do |format|
      format.json
    end
  end

  def show
    @product= Product.find(params[:id])
    @products_this_seller = @product.user.products.order('id DESC').where.not(id: params[:id]).limit(6)
    @category = @product.category
    @products_this_category = @category.products.order('id DESC').where.not(user_id:@product.user).limit(6)
    # @likes = @product.likes
    # @like  = @likes.find_by(user_id: current_user.id)
    @comment = Comment.new()
  end

  def edit
    @product= Product.find(params[:id])
    @parent = Category.order("id ASC").limit(1)
    @children =@parent[0].children 
    @grandchildren = @children[0].children
    gon.product = @product
    gon.product_images = @product.product_images

    # @item.item_imagse.image_urlをバイナリーデータにしてビューで表示できるようにする
    require 'base64'
    # require 'aws-sdk'

    gon.product_images_binary_datas = []
      @product.product_images.each do |image|
      binary_data = File.read(image.image.file.file)
      gon.product_images_binary_datas << Base64.strict_encode64(binary_data)
    end
  end 

  def update
    binding.pry
    @product= Product.find(params[:id])
    if params[:images].present? && @product.update(product_params)
      product_image_params[:images].each do |image|
        @product.product_images.build
        product_image = @product.product_images.(image: image)
        product_image.update
      end
    end
  end 
  
  def buy
  end

  def showmain
    @product= Product.find(params[:id])
    @products_this_seller = @product.user.products.order('id DESC').where.not(id: params[:id]).limit(6)
    @category = @product.category
    @products_this_category = @category.products.order('id DESC').where.not(user_id:@product.user).limit(6)
    # @likes = @product.likes
    # @like  = @likes.find_by(user_id: current_user.id)
    @comment = Comment.new()
  end

  private

  def product_params
      params.require(:product).permit(:title, :description, :category_id, :size, :brand_id, :condition, :shipping_charges, :shipping_area, :shipping_method, :shipping_date, :price).merge(user_id:current_user.id)
  end

  def product_image_params
    #imageのストロングパラメータの設定.js側でimagesをrequireすれば画像のみを引き出せるように設定する。
    params.require(:image).permit({images:[]})
  end
end