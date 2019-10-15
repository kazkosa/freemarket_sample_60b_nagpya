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
    # itemが保存できたかどうかで、画像の保存を分岐させたいために、newです。
    @product = Product.new(create_params)
    if @product.save
  
      image_params[:images].each do |image|
        #buildのタイミングは、newアクションでも可能かもしれません。buildすることで、saveした際にアソシエーション先のテーブルにも値を反映できるようになります。
        @product.images.build
        product_image = @product.images.new(image: image)
        product_image.save
      end
        #今回は、Ajaxのみの通信で実装するためHTMLへrespondする必要がないため、jsonのみです。
      respond_to do |format|
        format.json
      end
    end
  end
  
  private
  def create_params
      # images以外の値についてのストロングパラメータの設定
      product_params = params.require(:product).permit(:name, :description,:category_id, :size, :brand_id, :condition, :select_shipping_fee, :shipping_method, :area, :shipping_date, :price)
      return product_params
  end
  def product_params
    #imageのストロングパラメータの設定.js側でimagesをrequireすれば画像のみを引き出せるように設定する。
    params.require(:images).permit({:images => []})
  end
  
















  def show
  end
  def buy
  end
end