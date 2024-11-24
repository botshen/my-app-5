class MessagesController < ApplicationController
   before_action :set_message, only: [ :show, :edit, :update, :destroy ]

  def index
    @messages = Message.includes(:user, :comments)
                    .order(created_at: :desc)
                    .map do |message|
      {
        id: message.id,
        content: message.content,
        user_name: message.user.name,
        comments: message.comments.map { |comment| { id: comment.id, content: comment.content, user_name: comment.user.name, created_at: comment.created_at, updated_at: comment.updated_at } },
        created_at: message.created_at,
        updated_at: message.updated_at
      }
    end

    render json: @messages
  end

  def show
    render json: {
      message: {
        id: @message.id,
        content: @message.content,
        user_name: @message.user.name,
        comments: @message.comments.includes(:user).order(created_at: :desc).map { |comment|
          {
            id: comment.id,
            content: comment.content,
            user_name: comment.user.name,
            created_at: comment.created_at
          }
        },
        created_at: @message.created_at,
        updated_at: @message.updated_at
      }
    }
  end

  def new
    # 删除此方法，API模式不需要new action
  end

  def create
    user = User.find_or_create_by(name: params[:name])
    @message = user.messages.build(message_params)

    if @message.save
      render json: @message, status: :created
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  def edit
    # 删除此方法，API模式不需要edit action
  end

  def update
    if @message.user != current_user
      render json: { error: "没有权限编辑此留言" }, status: :forbidden
      return
    end

    if @message.update(message_params)
      render json: @message
    else
      render json: { errors: @message.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    if @message.user != current_user
      render json: { error: "没有权限删除此留言" }, status: :forbidden
      return
    end

    @message.destroy
    render json: { message: "留言已成功删除" }, status: :ok
  end

  private

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
