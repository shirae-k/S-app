class Post < ApplicationRecord
  validates :user_id,{presence: true}

  def user
    retrun User.find_by(id: self.user_id)
  end
  
end
