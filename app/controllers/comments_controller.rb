class CommentsController < ApplicationController
  def create
    @message = Message.find(params[:message_id])
    @user = User.find_or_create_by!(name: params[:name])
    @comment = @message.comments.build(comment_params)
    @comment.user_id = @user.id

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
