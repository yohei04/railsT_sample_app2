class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    # debugger
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      #       redirect_to  “/users/#{@user.id}”
      # ↓users _path  POST   /users(.:format)          users#create
      # redirect_to user_path(@user.id)
      # ↓user_pathの引数に渡すときはデフォルトでidを渡すのでわざわざidと書かなくてよい
      # redirect_to user_path(@user) == redirect_to user_url(@user)
      # ↓ redirect_toの引数にuserオブジェクトが入るとデフォルトでuser_path(@user)になる
      # redirect_to @user
      redirect_to @user #=>show action
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile Updated"
      redirect_to @user
    else
      render 'edit'
    end
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # before action

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

end

