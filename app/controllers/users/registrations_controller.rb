class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :select_plan, only: :new
  
  def create
    super do |resource|  #for importing everything from the parent class
      if params[:plan]
        resource.plan_id = params[:plan] #to store which plan id the user chooses
        if resource.plan_id == 2
          resource.save_with_payment
        else
          resource.save
        end
      end
    end
  end
  
  private 
    def select_plan
       unless params[:plan] && (params[:plan] == '1' || params[:plan] == '2')
          flash[:notice] = "Please select a membership plan to sign up."
          redirect_to root_url
       end
    end
end
