class PostsController < ApplicationController

  before_action :move_to_index, except: [:index, :show]

  def index
    @posts = Post.includes(:user).page(params[:page]).per(5).order("created_at DESC")
  end
  
  def new
    @post = Post.new
  end
  
  def create
    Post.create(post_params)
    redirect_to "/"
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy if post.user_id == current_user.id
    redirect_to "/"
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    if post.user_id == current_user.id
      post.update(post_params)
      redirect_to "/"
    end
  end

  private
  def post_params
    params.require(:post).permit(:text, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

end