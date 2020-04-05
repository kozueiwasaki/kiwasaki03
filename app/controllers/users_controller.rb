class UsersController < ApplicationController
  def index
    @users = User.all.order(created_at: :desc).page(params[:page]).per(5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # 初期画像を設定
    @user.image_name = "/public/user_images/user_default.png"
    if @user.save
      flash[:notice] = "登録が完了しました"
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.update(user_params)
    #　画像データが送信されたときだけ実行
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

  private

  def user_params
    params.require(:user).permit(:name, :email, :image_name)
  end

end
