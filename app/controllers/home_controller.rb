class HomeController < ApplicationController
  #ログインしているユーザーのアクセスを制限している
before_action :forbid_login_user, {only: [:top]}

  def top
  end

  def about
  end

end
