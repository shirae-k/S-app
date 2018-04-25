class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
   @user = User.new

  end

  def create
   @user = User.new(name: params[:name],
                    email: params[:email],
                    password: params[:password])
    if @user.save
      flash[:notice] = "登録が完了しました"
      redirect_to("/users/#{@user.id}")
      else
      render("users/new")
      end
      end


 def login_form
 end

 def login
   @user = User.find_by(
                    email: params[:email],
                    password: params[:password])
      if @user
        flash[:notice] = "ログインしました"
        redirect_to("/users/index")
        else
          @error_message ="メールアドレスかパスワードが間違ってます"
          @email  = params[:email]
          @password = params[:password]
          render("users/login_form")

      end
 end


end
