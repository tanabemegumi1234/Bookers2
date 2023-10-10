class UsersController < ApplicationController
	 before_action :authenticate_user!
   before_action :check_current_user, only: [:edit, :update]
   before_action :is_matching_login_user, only: [:edit, :update]

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
    @newbook = Book.new
  end


  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render "users/edit"
    end
  end

  def index
    @user = current_user
    @users = User.all
    @books = @user.books
    @book = Book.new
  end

private
def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
end

def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to post_images_path
    end
end

def check_current_user
    user = User.find(params[:id])
    if user != current_user
      redirect_to user_path(current_user.id)
    end
end

end