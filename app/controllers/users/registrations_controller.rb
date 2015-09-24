class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_sign_up_params, only: [:create]
  before_filter :configure_account_update_params, only: [:update]
  skip_before_action :require_login, only: [ :new, :create ]

  def new
	redirect_to posts_path if user_signed_in?
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
	  devise_parameter_sanitizer.for(:sign_up) << :attribute
	end

	def configure_account_update_params
	  devise_parameter_sanitizer.for(:account_update) << :attribute
	end

	def after_sign_up_path_for(resource)
	  super(resource)
	end

	def after_inactive_sign_up_path_for(resource)
	  super(resource)
	end
end
