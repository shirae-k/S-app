class Like < ApplicationRecord
  #user_idとpost_idの両方がなければならないバリデーション
  validates :user_id,{presence: true}
  validates :post_id,{presence: true}
end
