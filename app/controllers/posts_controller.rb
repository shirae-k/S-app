class PostsController < ApplicationController
#ログインしていないユーザーのアクセスを制限する
before_action :authenticate_user
#ログインしているユーザーが他のユーザーのpost編集画面にアクセスできないように制限する
before_action :ensure_crrect_user, {only: [:edit, :update, :destroy]}
#postのindexメソッド
  def index
    #DBにあるpostのデータをすべて持ってくる（新しいもの順に並べる）
    @posts = Post.all.order(created_at: :desc)
  end

#postの詳細ページのメソッド
  def show
    #ルーティングのURLから取得したIDを元にPostテーブルからデータを持ってくる
    @post = Post.find_by(id: params[:id])
    #ModelからreturnでuserのIDが返ってくる
    @user = @post.user
    #likeされているpostをLikeから持ってきて、数える@likes_countに代入
    @likes_count = Like.where(post_id: @post.id).count
    #postをみた数（閲覧数を数える）countカラムを@count代入している
    @count = @post.count
    #ログイン中のユーザーとpostユーザーが一致していない場合
    if @current_user != @user
      #ポストテーブルのcountカラムが+1される
        @post.count = @count  +  1
        end
        #postを保存する
     @post.save
  end


  #新しくpostを作るメソッド（ルーティングget）
  def new
  end

  #新しくpostを作るメソッド（ルーティングpost）
  def create

    #postを新しく作る
    #Postカラムにparamsでcontentの値を受け取る
    #user_idは現在ログインしているユーザーを入れる
  @post = Post.new(content: params[:content],
                   user_id: @current_user.id)
  #post.countの値をnillから0にする
  @post.count  = 0
         #imwgeの受け取りと、@imageへの代入
          @image = image = params[:image]
          #imegeがあった場合
        if @image != nil
          #日付を引用するための一文
         require "date"
         #上で持ってきた日付時間を@timeで定義する
          @time = DateTime.now
          #@posst.contentの命名をする。画像なので、ファイル形式も指定している。
          @post.content = "#{@post.user_id}#{@time}.jpg"
          #画像を入れるファイルの指定、ここで命名を指定する。image.readで画像の読み込みもしている
          File.binwrite("public/post_image/#{@post.content}",image.read)
          #postが保存できるか判断する
        if @post.save
          #保存できた場合、flashを表示
          flash[:notice] = "投稿しました"
          #redirect_toでpostsのindexに飛ばす
          redirect_to("/posts/index")
         else
           #保存できなかった場合、renderで新規投稿画面を表示する
          render("posts/new")
        end
        end

end

 #postを編集するメソッド(get)
  def edit
   #postをルーティングのURLから取得
 @post = Post.find_by(id: params[:id])
  end


 #postを編集するメソッド(post)
 def update
   #postをルーティングのURLから持ってくる
   #user_idは現在ログインしているユーザーから取得
   @post = Post.find_by(id: params[:id],
                        user_id: @current_user.id)
    #iemageがあるか判断する
   if params[:image]
        #あった場合@timeに現在の時間を代入する
       @time = DateTime.now
       #命名の規則を定義する
       @post.content = "#{@post.user_id}#{@time}.jpg"
       #imageをフォームから受け取る
       image = params[:image]
       #画像を入れるファイルの指定、ここで命名を指定する。image.readで画像の読み込みもしている
       File.binwrite("public/post_image/#{@post.content}",image.read)
       #postが保存できるか判断する
     if @post.save
       #保存できた場合、flashを表示
       flash[:notice] = "投稿を編集しました"
       #redirect_toでpostsのindexに飛ばす
       redirect_to("/posts/index")
     else
       #保存できなかった場合、renderでpost編集画面を表示する
      render("posts/edit")
 end
   end
  end



  def destroy
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    @post.destroy
    redirect_to("/users/#{@post.user_id}")

  end


 def ensure_crrect_user
   @post = Post.find_by(id: params[:id])
   if @post.user_id != @current_user.id
     flash[:notice] = "権限がありません"
     redirect_to("/posts/index")
   end
 end




  end
