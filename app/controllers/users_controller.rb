class UsersController < ApplicationController
    
    before_action :current_user_is_admin, only: [:edit, :update, :new, :create, :destroy]
   
   
    def destroy
        User.find(params[:id]).destroy
        flash[:success] = "User Deleted"
        redirect_to admin_path
    end
    
    
    def new
        @user = User.new
    end
   
    def create
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "User Created"
            redirect_to edit_user_path(@user)
        else
            render 'new'
        end
       
    end
   
    def edit
        @user = User.find(params[:id])
    end
  
    def update
        @user = User.find(params[:id])
        @user.update(user_params)
        flash[:success] = "User updated"
        redirect_to edit_user_path(@user)
    end
   
   
    private
   
    def user_params
        params.require(:user).permit(:username, :password, :company_name, :admin)
    end
   
   
    def current_user_is_admin
        current_user.admin?
    end
  
end
