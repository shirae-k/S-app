class CommentsController < ApplicationController
before_action :authenticate_user

def new
        @comment = Comment.new
end



def comment_create
  @comment = Comment.new(com: params[:com],
                   user_id: @current_user.id,
                   post_id: params[:post_id])
  @comment.post_id = params[:post_id]
   if @comment.save
     flash[:notice] = "コメントを作成しました"
     redirect_to("/posts/#{params[:post_id]}")
   else
      render("posts/index")
  end
end

def show
  @comments = Comment.all.order(created_at: :desc)

end

end
