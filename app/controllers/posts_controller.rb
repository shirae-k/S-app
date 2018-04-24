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
    @post = Post.new(content: params[:content])
     @post.save
     redirect_to("/posts/index")
    #@post = Post.find_by(id: params[:id])
    #@user = User.find_by(id: params[:id])
    #@post.content = "#{@user.id}#{@post.id}.jpg"
    #redirect_to("/posts/index")
  end
end
