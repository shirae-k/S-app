class ApplicationController < ActionController::Base
  before_action :set_current_user


    #ログインしているユーザーの定義
  def set_current_user
    #ログインしているユーザーの定義、find_byでUserテーブルからユーザーを探している
     @current_user = User.find_by(id: session[:user_id])
  end

  #ログインしてないユーザーの場合の処理
  def authenticate_user
    #ログインしているユーザーがいない場合
    #もし、ログインしているユーザーがいないとき
    if @current_user == nil
      #flashで表示
      flash[:notice] = "ログインが必要です"
       #redairectでログインページに飛ばす
      redirect_to("/login")
    end
  end

#すでにログイン済みのユーザーの場合の処理
  def  forbid_login_user
    #ログインユーザーがいた場合の処理
    if  @current_user
      #もしログイン中のユーザーがいたら
      #flashで表示
      flash[:notice] = "ログイン済みです"
      #redairectでuserのindexに飛ばす
      redirect_to("/users/index")
    end
end


end
