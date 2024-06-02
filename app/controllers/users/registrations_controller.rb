class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?

    register_failed(resource.errors.full_messages)
  end
  
  def register_success
    render json: { message: 'Signed up successfully.' }, status: :ok
  end

  def register_failed(error_message)
    if error_message.nil?
      render json: { message: "Something went wrong." }, status: :unprocessable_entity
    else
      render json: { message: error_message.join(', ') }, status: :unprocessable_entity
    end
  end
end