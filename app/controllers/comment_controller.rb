def com_new
  @comment = Comment.new
end

def com_create
  @comment = Comment.new(com: params[:com],
                   user_id: @current_user.id,
                   post_id: params[:post_id])
   if @post.save
     flash[:notice] = "コメントを作成しました"
     redirect_to("/posts/index")
   else
      render("posts/show")
end
