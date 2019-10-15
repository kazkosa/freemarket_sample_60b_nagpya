class RegulationController < ApplicationController
  def new
  end

  def index
  end

  def created
  end

  def singup1        #user情報
    @user = User.new
  end   

  def singup2
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:family_name] = user_params[:family_name]
    session[:first_name] = user_params[:first_name]
    session[:family_name_kana] = user_params[:family_name_kana]
    session[:first_name_kana] = user_params[:first_name_kana]
    session[:birthday_year] = user_params[:birthday_year]
    session[:birthday_month] = user_params[:birthday_month]
    session[:birthday_day] = user_params[:birthday_day]
    @user = User.new
  end   

  def singup3     #address情報
    # binding.pry
    @user = User.new
    @address = Address.new
    # @user.build_address
  end   

  def singup4    #pays情報
    # binding.pry
    session[:post_num] = address_params[:post_num]
    session[:prefectures] = address_params[:prefectures]
    session[:municipalities] = address_params[:municipalities]
    session[:block_number] = address_params[:block_number]
    session[:building] = address_params[:building]
    session[:phone_number] = address_params[:phone_number]
    @user = User.new
    @address = Address.new
    @pay = Pay.new
    # @user.build_pay
  end
  
  def create
    # binding.pry
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      family_name: session[:family_name],
      first_name: session[:first_name],
      family_name_kana: session[:family_name_kana],
      first_name_kana: session[:first_name_kana],
      birthday_year: session[:birthday_year],
      birthday_month: session[:birthday_month],
      birthday_day: session[:birthday_day] 
    )
     binding.pry
    if @user.save
      session[:user_id] = @user.id
      @address = Address.new(
      user_id: session[:user_id],
      post_num: session[:post_num],
      prefectures: session[:prefectures],
      municipalities: session[:municipalities],
      block_number: session[:block_number],
      building: session[:building],
      phone_number: session[:phone_number] 
      )
      binding.pry
      @pay = Pay.new(
      card_id: session[:card_id],
      year: session[:year],
      month: session[:month],
      security_number: session[:security_number]
      )
      redirect_to singup5_regulation_index_path
    else
      redirect_to root_path
    end
  end  
  
  def singup5   #登録完了
  end  

  private

  def user_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :family_name,:first_name,:nickname,
      :family_name_kana,:first_name_kana,:birthday_year,:birthday_month,:birthday_day, address_attributes: [:id], pay_attributes: [:id])
  end

  def address_params
    params.require(:address).permit(:post_num, :prefectures, :municipalities, :block_number, :building, :phone_number)
  end

  def pay_params
    params.require(:pay).permit(:card_id, :year, :month, :security_numnber)
  end

end
