class ProductsController < ApplicationController
  before_action :set_product, only:[:edit, :update, :show, :pay,:buy]
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

  def edit
    @parent = Category.order("id ASC").limit(1)
    @children =@parent[0].children 
    @grandchildren = @children[0].children
    @product.product_images.build
    @product.product_images.each do |product_image|
      product_image.image.cache!
    end
  end
  def update
    if @product.update(product_params)
      @product_images = @product.product_images
      delete_product_image_ids = []
      if delete_product_image_params.present?
        delete_product_image_params[:delete_request_index].each do |index|
          delete_product_image_ids << @product_images[index.to_i].id
        end
        delete_product_image_ids.each do |id|
          product_image = @product_images.find(id)
          product_image.destroy
        end
      end
      if params[:image].present?
        product_image_params[:images].each do |image|
          @product_images.build
          product_image = @product_images.new(image: image)
          product_image.save
        end
      end
      
    end
    respond_to do |format|
      format.json
    end
  end

  def show
    @products_this_seller = @product.user.products.order('id DESC').where.not(id: params[:id]).limit(6)
    @category = @product.category
    @products_this_category = @category.products.order('id DESC').where.not(user_id:@product.user).limit(6)
    @likes = @product.likes
    @like  = @likes.find_by(user_id: current_user.id)
    @comment = Comment.new()
  end

  def buy
    @address = current_user.address
    @card = Card.find_by(user_id: current_user.id)
    unless @card.blank?
      Payjp.api_key = ENV["CARD_SEECRET_KEY"]
      Payjp.read_timeout = 90
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end
  def pay
    card = Card.find_by(user_id: current_user.id)
    Payjp.api_key = ENV["CARD_SEECRET_KEY"]
    Payjp.read_timeout = 90
    Payjp::Charge.create(
      amount: @product.price,     #支払金額
      customer: card.customer_id, #顧客ID
      currency: 'jpy',            #日本円
    )
    @product.update(buyer_id: current_user.id)
  end

  private

  def product_params
      params.require(:product).permit(:title, :description, :category_id, :size, :brand_id, :condition, :shipping_charges, :shipping_area, :shipping_method, :shipping_date, :price).merge(user_id:current_user.id)
  end

  def product_image_params
    params.require(:image).permit({images:[]})
  end

  def delete_product_image_params
    params.require(:product).permit({delete_request_index:[]})
  end

  def set_product
    @product = Product.find(params[:id])
  end
end