class UsersController < ApplicationController

  def index
  end

  def show
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to books_path(user.id)
  end


   private
  def user_params
    params.require(:book).permit(:name, :introduction, :profile_image)
  end



end
