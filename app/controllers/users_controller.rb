class UsersController < ApplicationController
  def show
    user = User.find_by_id params[:id]
    if user
      render json: user
    else
      head :not_found
    end
  end

  def create
    user = User.new email: "frank@example.com"
    if user.save
       render json: user
    else
       render json: user.errors
    end
  end
end
