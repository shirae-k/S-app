class PostsController < ApplicationController
  def index
    @post = Post.all.order(created_at:desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
    @id =  params[:id]
  end

  def new
    @post = Post.find_by(id: params[:id])
    @post.image_name = "#{@user.id}#{created_at}.jpg"
    if @post.save
  end
end
