class LikesController < ApplicationController
  #ログインしていないユーザーのアクセスを制限する
before_action :authenticate_user

#likeを作るメソッド
  def create
    #新しいlikeをDBに追加する処理
    #user_idは現在ログインしているユーザー
      #post_idはルーティングのURLから持ってくる
    @like = Like.new(
      user_id: @current_user.id,
      post_id: params[:post_id]
    )
    #@likeを保存する（@likeはModelクラスなので、保存できる）
    @like.save
    #保存できたらredairectで今まで見いていたpost詳細ページに飛ぶ
    redirect_to("/posts/#{params[:post_id]}")
  end

  #likeを消すメソッド
  def destroy
    #likeを探す処理
    #user_idは現在ログインしているユーザー
    #post_idはルーティングのURLから持ってくる
    @like = Like.find_by(
      user_id: @current_user.id,
      post_id: params[:post_id]
    )
    #likeを消す処理
    @like.destroy
     #likeを消せたら、今まで見いていたpost詳細ページに飛ぶ
    redirect_to("/posts/#{params[:post_id]}")
  end
end
