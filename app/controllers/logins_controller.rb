class LoginsController < ApplicationController
    
    def new
       
    end
    
    def create
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            flash[:success] = "You are logged in."
            if user.admin?
                redirect_to admin_path
            elsif user.stores.count == 1
                redirect_to store_path(user.stores.first.id)
            else
                redirect_to stores_path
            end
        else
            flash[:danger] = "Username or password incorrect."
            render 'new'
        end
    end
    
    def destroy
        session[:user_id] = nil
        flash[:success] = "You have logged out."
        redirect_to login_path
    end
    
    
end