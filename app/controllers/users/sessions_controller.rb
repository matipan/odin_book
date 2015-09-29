class Users::SessionsController < Devise::SessionsController
  before_filter :configure_sign_in_params, only: [:create]

  def new
	super
  end

  def create
	super
  end

  def destroy
	super
  end

  protected

	def configure_sign_in_params
	  devise_parameter_sanitizer.for(:sign_in) << :attribute
	end
end
