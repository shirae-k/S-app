class PostsController < ApplicationController

before_action :authenticate_user
before_action :ensure_crrect_user, {only: [:edit, :update, :destroy]}


  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @id =  params[:id]
    @likes_count = Like.where(post_id: @post.id).count
    @count = @post.count
    if @current_user != @user
        @post.count = @count  +  1
        end
     @post.save
  end




  def new
  @post = Post.new
  end


  def create
  @post = Post.new(content: params[:content],
                   user_id: @current_user.id)
  @post.count  = 0
          image = params[:image]
        if image = params[:image] != nil
         require "date"
          @time = DateTime.now
          @post.content = "#{@post.user_id}#{@time}.jpg"
          image = params[:image]
          File.binwrite("public/post_image/#{@post.content}",image.read)
          @post.save
          redirect_to("/posts/index")
         else
          render("posts/new")

        end

end


  def edit
 @post = Post.find_by(id: params[:id])
  end



 def update
   @post = Post.find_by(id: params[:id],
                        user_id: @current_user.id)
   if params[:image]
       @time = DateTime.now
       @post.content = "#{@post.user_id}#{@time}.jpg"
       image = params[:image]
       File.binwrite("public/post_image/#{@post.content}",image.read)
  end

     if @post.save
       flash[:notice] = "投稿を編集しました"
       redirect_to("/posts/index")
     else
      render("posts/edit")
 end
  end



  def destroy
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    @post.destroy
    redirect_to("/users/#{@post.user_id}")

  end


 def ensure_crrect_user
   @post = Post.find_by(id: params[:id])
   if @post.user_id != @current_user.id
     flash[:notice] = "権限がありません"
     redirect_to("/posts/index")
   end
 end




  end
