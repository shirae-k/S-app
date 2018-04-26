class PostsController < ApplicationController

before_action :authenticate_user




  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
    @id =  params[:id]
  end


  def new
  @post = Post.new
  end

  def create
  @post = Post.new(content: params[:content])
   @user = User.find_by(id: params[:id])
   @post.content = "#{@user.id}#{@post.id}.jpg"

    image = params[:image]
    File.binwrite("public/post_image/#{@post.content}",image.read)
    @post.save

    #redirect_to("/posts/index")

  end

end
