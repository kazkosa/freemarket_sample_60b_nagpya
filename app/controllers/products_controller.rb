class ProductsController < ApplicationController
  before_action :set_product, only:[:edit, :update, :show, :pay, :buy, :destroy, :pend, :resell, :ship, :recieve, :close, :showmain, :show_transaction_main, :show_completed_main, :purchase_transaction, :purchase_completed]

  def index 
    @products = Product.order("id DESC").limit(5)
  end
  def sell
    @product= Product.new()
    @parent = Category.where(ancestry: nil)
    @children = Category.none
    @grandchildren = Category.none
    @product.product_images.build
  end 

  def select_category_m
    parent = Category.find_by(id: params[:category_id1])
    @children = parent.children
    respond_to do |format|
      format.json
    end
  end
  def select_category_s
    child= Category.find_by(id: params[:category_id2])
    @grandchildren = child.children
    respond_to do |format|
      format.json
    end
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
    @grandchildren  = Category.where(id: @product.category_id)
    @children       = Category.where(id: @grandchildren[0].parent)
    @parent         = Category.where(ancestry: nil)
    @parent_current = Category.find_by(id: @children[0].parent.id)

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
    if user_signed_in? 
      @likes = @product.likes
      @like  = @likes.find_by(user_id: current_user.id)
    end  
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
    @product.state_transition("waiting_for_shipping")
  end

  def showmain
    @products_this_seller = @product.user.products.order('id DESC').where.not(id: params[:id]).limit(6)
    @category = @product.category
    @products_this_category = @category.products.order('id DESC').where.not(user_id:@product.user).limit(6)
    @comment = Comment.new()
  end

  def destroy
    if @product.destroy
      redirect_to showedit_user_path(current_user)
    end
  end

  def pend
    @product.state_transition("pending")
    redirect_to showmain_product_path(@product)
  end

  def resell
    @product.state_transition("in_sale")
    redirect_to showmain_product_path(@product)
  end

  def ship
    @product.state_transition("on_delivery")
    redirect_to show_transaction_main_product_path(@product)
  end

  def recieve
    @product.state_transition("arrived")
    redirect_to purchase_transaction_product_path(@product)
  end

  def close
    @product.state_transition("completed")
    redirect_to show_completed_main_product_path(@product)
  end

  def show_transaction_main
  end

  def show_completed_main
  end

  def purchase_transaction
  end

  def purchase_completed
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