class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_sign_up_params, only: [:create]
  before_filter :configure_account_update_params, only: [:update]

  def new
	super
  end

  def create
	super
  end

  def edit
	super
  end

  def update
	super
  end

  def destroy
	super
  end

  def cancel
	super
  end

  protected

	def configure_sign_up_params
	  devise_parameter_sanitizer.for(:sign_up).push(:name, :last_name)
	end

	def configure_account_update_params
	  devise_parameter_sanitizer.for(:account_update).push(:name, :last_name)
	end

	def after_sign_up_path_for(resource)
	  super(resource)
	end

	def after_inactive_sign_up_path_for(resource)
	  super(resource)
	end
end
