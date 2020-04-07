class PostsController < ApplicationController
  before_action :authenticate_user

  def index
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(5)
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "投稿が完了しました"
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿を編集しました"
      redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:content).merge(user_id: @current_user.id)
  end
end
