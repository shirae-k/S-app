class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
    @id =  params[:id]
  end


  def new

  end

  def create

   @post = Post.find_by(id: params[:id])
   @user = User.find_by(id: params[:id])
   @post.name = "#{@user.id}#{@post.id}.jpg"


    image = params[:image]
    redirect_to("/posts/index")
    File.binwrite("public/post_images/#{@post.name}",image.read)


  end

end
