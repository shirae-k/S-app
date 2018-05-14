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
 #userの編集のページに対するメソッド(get)
 def edit
   #userのidをルーティングのURLから取得
     @user = User.find_by(id: params[:id])
 end

 #userの編集メソッド
 def update
#ユーザーのIDをルーティングのURLから取得
     @user = User.find_by(id: params[:id])
     #userのnameを入力フォームから取得
     @user.name = params[:name]
     #userのemailを入力フォームから取得
     @user.email = params[:email]
     #imageがあるか判断
    if params[:image]
      #imageがあった場合、命名規則を定義
       @user.image_name = "#{@user.id}.jpg"
       #imegeをフォームから受け取る
       image = params[:image]
       #画像を入れるファイルの指定、ここで命名を確定する。image.readで画像の読み込みもしている
       File.binwrite("public/user_images/#{@user.image_name}",image.read)
    end
    #userのテーブルに保存できるか判断する
    if @user.save
      #保存できた場合、redairect_toでusersの詳細ページに飛ぶ
       redirect_to("/users/#{@user.id}")
       #保存できなかった場合
   else
     #編集画面を再表示する
       render("users/edit")
   end
end

#userを新しく作るページに対するメソッド(ルーティングget)
  def new
    #userを新しく作る
   @user = User.new
  end

  #userを新しく作るメソッド(ルーティングpost)
  def create
    #userのname,email,passwardを入力フォームから取得
    #user作成時は、デフォルトの画像を使いプロフィールを作成する
   @user = User.new(name: params[:name],
                    email: params[:email],
                    password: params[:password],
                    image_name: "default_user_image.jpeg"
                   )
#userのデータを保存できるか判断する
     if @user.save
       #sessionでuser.idをブラウザから取得し、保持したままページ移動できるようにする
      session[:user_id] = @user.id
      #flashでメッセージを表示する
      flash[:notice] = "登録が完了しました"
      #redirect_toでuserのshowに飛ばす
      redirect_to("/users/#{@user.id}")
       #保存できなかった場合
     else
       #renderで新規ユーザー作成画面を表示する
      render("users/new")
     end
  end

  #login_formのページに対するメソッド
 def login_form
 end

 #loginに対するメソッド
 def login
   #入力フォームから、email,passwordを受け取り、@userに代入する
     @user = User.find_by(email: params[:email], password: params[:password])
     #@userがあるかどうかの判断
         if @user
           #現在ログインしているユーザーのidがsessionによって@user.idに代入される
            session[:user_id] = @user.id
            #flashでメッセージを表示する
            flash[:notice] = "ログインしました"
             #redirect_toでuserのindexに飛ばす
            redirect_to("/users/index")
         else
           #@userを見つけられなかった場合、メッセージを出す
            @error_message ="メールアドレスかパスワードが間違ってます"
            #emailとpasswordの入力値の表示
            @email  = params[:email]
            @password = params[:password]
            #renderでログインフォーム画面を表示する
            render("users/login_form")
         end
 end

 #logoutするメソッド
 def logout
   #sessionの値をnilにすることで、ログイン状態を解除する
     session[:user_id] = nil
     #flashでメッセージを表示する
     flash[:notice] ="ログアウトしました"
     #redirect_toでログインフォームに飛ばす
     redirect_to("/login")
 end

#likesのメソッド
 def likes
   #ルーティングのURLからuser.idを取得
   @user = User.find_by(id: params[:id])
   #いいねしたpostをlikes_postsに代入
   @like_posts = @user.like_posts
 end

#現在ログインしているユーザー以外のユーザーが権限のないページを表示しようとしたときに出すflashに関するメソッド
 def ensure_correct_user
   #現在ログインしているユーザーとルーティングのURLから取得したuser_idと一致しない場合
     if  @current_user.id != params[:id].to_i
       #flashでメッセージを表示する
        flash[:notice] = "権限がないです"
         #redirect_toでユーザーの一覧に飛ばす
        redirect_to("/users/index")
     end
 end
 end
