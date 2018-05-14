class User < ApplicationRecord
  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}
  validates :password,{presence: true}

#likesのpostsのメソッド
def posts
#複数のpostを今のidをもとに取得
  return Post.where(user_id: self.id)
end

#like_postsに関するメソッド
def like_posts
#空の配列を作成する
     posts = []

#現在ログインしているユーザーのidを使用していいねした複数のpostを取得
      likes = Like.where(user_id: self.id)

#eachで分配し、一つずつpostが入るようにする
      likes.each do |like|
        #likeしたpostを一つずつ取得し、postに代入
      post = Post.find_by(id: like.post_id)
      #posts.pushで配列に入れる
      posts.push(post)
    end
#returnでpostsの値を返す
       return posts

    end


end
