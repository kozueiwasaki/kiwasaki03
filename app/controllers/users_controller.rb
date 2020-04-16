class UsersController < ApplicationController
  # ログインしていないユーザのアクセスを防ぐ
  before_action :authenticate_user, only: [:index, :show, :edit, :update]
  # すでにログインしているユーザのアクセスを防ぐ
  before_action :forbid_login_user, only: [:new, :create, :login_form, :login]
  # ログイン中のユーザと操作中のユーザが同一でないとき
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @users = User.all.order(created_at: :desc).page(params[:page]).per(5)
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    # 初期画像を設定
    @user.image_name = "user_default.png"
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "登録が完了しました"
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @posts = @user.posts.page(params[:page]).per(5).order("created_at DESC")
    @likes = Like.where(user_id: @user.id).page(params[:page]).per(5).order("created_at DESC")
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.update(user_params)
    
    # 画像データが送信されたときだけ実行
    if user_params[:image_name]
      # 画像のファイル名をDBに保存
      @user.image_name = "#{@user.id}.jpg"
      # 画像ファイルの情報をうけとる
      image = user_params[:image_name]
      # public/user_images配下にファイルを保存
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end
    
    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def login_form
    
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to root_path
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = user_params[:email]
      @password = user_params[:password]
      render :login_form
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :image_name, :password)
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to root_path
    end
  end

end
