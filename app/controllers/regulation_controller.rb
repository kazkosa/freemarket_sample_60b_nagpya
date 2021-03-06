class RegulationController < ApplicationController
  before_action :save_to_session1, only: :singup2
  before_action :save_to_session2, only: :create


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
    
    @user = User.new
    @address = Address.new
  end   


  def singup5   #登録完了
    sign_in User.find(session[:user_id]) unless user_signed_in?
  end  

  def save_to_session1
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
    render '/regulation/singup1' unless @user.valid?
  end

  def save_to_session2
    @address = Address.new(
      user_id: session[:user_id],
      post_num: address_params[:post_num],
      prefectures: address_params[:prefectures],
      municipalities: address_params[:municipalities],
      block_number: address_params[:block_number],
      building: address_params[:building],
      phone_number: address_params[:phone_number]  
    )
    
    render '/regulation/singup3' unless @address.valid?
  end

  def create   
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
    
    if @user.save
      session[:user_id] = @user.id
      @address = Address.new(
      user_id: session[:user_id],
      post_num: address_params[:post_num],
      prefectures: address_params[:prefectures],
      municipalities: address_params[:municipalities],
      block_number: address_params[:block_number],
      building: address_params[:building],
      phone_number: address_params[:phone_number] 
      )
      @address.save
      sign_in User.find(session[:user_id]) unless user_signed_in?
      redirect_to new_card_path 
    else
      redirect_to singup3_regulation_index_path
    end
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

  
end
