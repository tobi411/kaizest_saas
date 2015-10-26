class ProfilesController < ApplicationController #Controllers should always be pluralized
    def new
        @user = User.find(params[:user_id]) #find logged in user
        @profile = @user.build_profile #because each user has a profile(as in routes.rb) we can call this method
    end
    
    def create
       @user = User.find( params[:user_id] )
        @profile = @user.build_profile(profile_params)
        if @profile.save
          flash[:success] = "Profile Updated!"
          redirect_to user_path( params[:user_id] )
        else
          render action: :new
        end
    end
    
    private 
        def profile_parmas
            params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description) #used for validation and avoiding XSS
        end
end