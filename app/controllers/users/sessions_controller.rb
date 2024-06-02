class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    login_success && return if resource.persisted?

    login_failed
  end

  def login_success
    render json: {
       message: 'Logged in successfully.',
       user: current_user
    }, status: :ok
  end

  def login_failed
    render json: { message: "Invalid email or password." }, status: :unauthorized
  end

  def respond_to_on_destroy
    logout_success  && return if current_user

    logout_failed
  end

  def logout_success
    render json: { message: "Logged out successfully." }, status: :ok
  end

  def logout_failed
    render json: { message: "Something went wrong." }, status: :unprocessable_entity
  end

end 