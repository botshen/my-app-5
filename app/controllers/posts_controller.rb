class PostsController < ApplicationController
  def index
    render json: { message: "Hello, world!" }
  end
end
