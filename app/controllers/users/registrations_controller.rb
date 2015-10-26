class Users::RegistrationsController < Devise::RegistrationsController
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
end
