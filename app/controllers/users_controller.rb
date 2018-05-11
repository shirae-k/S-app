class UsersController < ApplicationController

  before_action :authenticate_user, {only: [:index,:show,:edit,:update]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user,{only: [:edit, :update]}
  #userのindexのメソッド
 def index
   #userすべてをDBから取得
    @users = User.all
 end
  #user詳細ページのメソッド
 def show
   #userのidをルーティングのURLからidを取得
      @user = User.find_by(id: params[:id])
 end
 #userの編集メソッド(get)
 def edit
   #userのidをルーティングのURLから取得
     @user = User.find_by(id: params[:id])
 end
 #userの編集メソッド
 def update
   #userのidをルーティングのURLから取得
     @user = User.find_by(id: params[:id])
     #userのnameを入力フォームから取得
     @user.name = params[:name]
     #userのemailを入力フォームから取得
     @user.email = params[:email]
     #imageがあるか判断
    if params[:image]
      #imageがあった場合、命名規則を定義
       @user.image_name = "#{@user.id}.jpg"
       #imegeがフォームから受け取る
       image = params[:image]
       #画像を入れるファイルの指定、ここで命名を指定する。image.readで画像の読み込みもしている
       File.binwrite("public/user_images/#{@user.image_name}",image.read)
    end
    #userのテーブルに保存
    if @user.save
      #保存できた場合redairect_toでusersの詳細ページに飛ぶ
       redirect_to("/users/#{@user.id}")
   else
     #保存できなかった場合、編集画面を再表示する
       render("users/edit")

   end
end

  #userを新しく作るメソッド(ルーティングget)
  def new
    #userを新しく作る
   @user = User.new

  end
#userを新しく作るメソッド(ルーティングpost)
  def create
     #userのname,email,passward,image_nameを入力フォームから取得
   @user = User.new(name: params[:name],
                    email: params[:email],
                    password: params[:password],
                    image_name: "default_user_image.jpeg"
                   )
     #userのデータを保存できるか判断する
     if @user.save
       #user_idをsessionで保持したままページ移動できるようにする
      session[:user_id] = @user.id
      flash[:notice] = "登録が完了しました"
      redirect_to("/users/#{@user.id}")
     else
      render("users/new")
     end
  end


 def login_form
 end

 def login
     @user = User.find_by(email: params[:email], password: params[:password])
         if @user
            session[:user_id] = @user.id
            flash[:notice] = "ログインしました"
            redirect_to("/users/index")
         else
            @error_message ="メールアドレスかパスワードが間違ってます"
            @email  = params[:email]
            @password = params[:password]
            render("users/login_form")

         end
 end
 def logout
     session[:user_id] = nil
     flash[:notice] ="ログアウトしました"
     redirect_to("/login")
 end

 def likes
   @user = User.find_by(id: params[:id])
   @like_posts = @user.like_posts
 end

 def ensure_correct_user
     if  @current_user.id != params[:id].to_i
        flash[:notice] = "権限がないです"
        redirect_to("/users/index")
     end
 end

end
