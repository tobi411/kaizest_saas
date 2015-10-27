class ProfilesController < ApplicationController #Controllers should always be pluralized
    before_action :authenticate_user! #make sure the user is logged in
    before_action :only_current_user
    def new
        @user = User.find(params[:user_id]) #find logged in user
        @profile = @profile = Profile.new #not using @user.build_profile(profile_params) to avoid unlinking user to profile
    end
    
    def create
       @user = User.find( params[:user_id] )
        @profile = @user.build_profile(profile_params) #because each user has a profile(as in routes.rb) we can call this method
        if @profile.save
          flash[:success] = "Profile Updated!"
          redirect_to user_path( params[:user_id] )
        else
          render action: :new #render the new action and view
        end
    end
    
    def edit
        @user = User.find( params[:user_id] )
        @profile = @user.profile
    end
    
    def update
        @user = User.find(params[:user_id])
        @profile = @user.profile
        if @profile.update_attributes(profile_params) #saves any changes to the database
            flash[:success] = "Profile Updated!"
            redirect_to user_path(params[:user_id])
        else
            render action: :edit
        end
    end
    
    private 
        def profile_params
            #whitelisting used to save data from forms to database and for safety
            params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description) 
        end
        def only_current_user
          @user = User.find( params[:user_id] )
          redirect_to(root_url) unless @user == current_user #if the user passed through the url is the current user, proceed. If not go back to the home page
        end
end