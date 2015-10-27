class UsersController < ApplicationController
     before_action :authenticate_user! #make sure the user is logged in
    def show
        @user = User.find(params[:id])
    end
    
    def index
        @users = User.all
    end
end