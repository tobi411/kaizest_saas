class ProfilesController < ApplicationController #Controllers should always be pluralized
    def new
        @user = User.find(params[:user_id]) #find logged in user
        @profile = @user.build_profile #because each user has a profile(as in routes.rb) we can call this method
    end
end