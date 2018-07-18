class UsersController < ApplicationController
  def index
   @users = User.all
  end
  def edit
  	@user = User.find(params[:id])
  end


  def show
          @user = User.find(params[:id])
	  	  @problems= @user.problems	 
	  	  @problem=Problem.find(params[:id])
  end

  def fullname
   	"#{name} #{surname}"
  end 

   
end