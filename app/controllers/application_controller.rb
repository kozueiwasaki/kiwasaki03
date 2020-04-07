class ApplicationController < ActionController::Base
  before_action :set_current_user
  
  #これはすべてのコントローラのアクションで使える
  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  # ログインしていないユーザのアクセスを防ぐ
  def authenticate_user
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to login_users_path
    end
  end

  # すでにログインしているユーザのアクセスを防ぐ
  def forbid_login_user
    if @current_user
      flash[:notice] = "すでにログインしています"
      redirect_to root_path
    end
  end

end
