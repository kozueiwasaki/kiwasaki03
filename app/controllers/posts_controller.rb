class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  def index
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(5)
  end

  def show
    @likes_count = Like.where(post_id: @post.id).count
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
    
  end

  def update
    
    if @post.update(post_params)
      flash[:notice] = "投稿を編集しました"
      redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to posts_path
  end

  def search
    # formで取得したパラメータにkeywordというキーをつけてモデルに送る
    @posts = Post.search(params[:keyword]).order(created_at: :desc).page(params[:page]).per(5)
  end

  private

  def post_params
    params.require(:post).permit(:content).merge(user_id: @current_user.id)
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to posts_path
    end
  end

  def set_post
    @post = Post.find_by(id: params[:id])
  end
end
