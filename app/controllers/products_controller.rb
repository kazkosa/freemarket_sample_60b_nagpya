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
    #binding.pry
    # productが保存できたかどうかで、画像の保存を分岐させたいために、newです。
    @product = Product.new(product_params)
    #binding.pry
    # @product = Product.new(title: "test", description: "test_description", category_id: 1, size:"L",  condition:"Good", shipping_charges:"500", shipping_area:1, shipping_method:"着払い", shipping_date:"2~3日", price:1500,user_id:1 )
    if @product.save
      product_image_params[:images].each do |image|
        #buildのタイミングは、newアクションでも可能かもしれません。buildすることで、saveした際にアソシエーション先のテーブルにも値を反映できるようになります。
        @product.product_images.build
   
        product_image = @product.product_images.new(image: image)
    
        product_image.save
      end
      #今回は、Ajaxのみの通信で実装するためHTMLへrespondする必要がないため、jsonのみです。
      # binding.pry
      respond_to do |format|
        format.json
      end
    else
      render "/products/sell" unless @product.valid?
    end
  end
  
  private
  def product_params
      # images以外の値についてのストロングパラメータの設定
      params.require(:product).permit(:title, :description, :category_id, :size, :brand_id, :condition, :shipping_charges, :shipping_area, :shipping_method, :shipping_date, :price).merge(user_id:current_user.id)
  end
  def product_image_params
    #imageのストロングパラメータの設定.js側でimagesをrequireすれば画像のみを引き出せるように設定する。
    params.require(:image).permit({:images => []})
  end


  def show
  end
  def buy
  end
end