class Post < ApplicationRecord
  #user_idとcontentの両方がなければならないバリデーション
  validates :content,{presence: true}
  validates :user_id,{presence: true}

#userに関するメソッド
  def user
#returnでログインしているユーザーのuser_idの値を返す
  return User.find_by(id: self.user_id)
end



end
