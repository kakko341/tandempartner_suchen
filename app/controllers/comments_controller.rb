class CommentsController < ApplicationController
	before_action :require_user_logged_in
  
  def new
  	@message = Message.find(params[:message_id])
  	@comment = Comment.new
  end
  
  def create
    @message = Message.find(params[:message_id])
    @comment = current_user.comments.build(comment_params)
    @comment.message_id = @message.id
    if @comment.save!
     flash[:success] = 'Replied!'
     redirect_to root_url
    else
     flash[:danger] = 'Failed to reply'
     render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = 'Deleted the reply'
    redirect_back(fallback_location: root_url)
  end
  
  private
  
	  def comment_params
	  	params.require(:comment).permit(:content)
	  end
end
