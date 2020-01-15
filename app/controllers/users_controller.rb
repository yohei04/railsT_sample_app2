class UsersController < ApplicationController
  

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



  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end

