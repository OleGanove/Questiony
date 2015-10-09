class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  helper_method :question_owner?

  protected

  def configure_permitted_parameters
  	devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
  	devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :gender, :age, :email, :password, :password_confirmation, :current_password) }
  end

  def authorize
  	unless question_owner?
  	  flash[:notice] = "Unauthorized access"
  	  redirect_to root_path
  	  false
  	end
  end

  def question_owner?
  	@question = Question.find(params[:id])
  	@question.user_id == current_user.id
  end
end
