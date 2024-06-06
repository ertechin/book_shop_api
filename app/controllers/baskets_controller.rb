class BasketsController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_update_actions, only: :update
  before_action :ensure_basket_exists, only: %i[ show update clear]
  before_action :has_empty_basket, only: :clear
  before_action :set_basket, only: %i[ show update ]

  def show
    set_books
  end

  def update
    update_state, message = @basket.update_logic(basket_params)
    if update_state
      prepare_show
      render(:show, status: :ok)
    else
      render_message(message)
    end
  end

  def clear
    create
    if @basket
      prepare_show
      render(:show, status: :ok)
    else
      render_message('basket_not_found', :internal_server_error)
    end
  end

  private

  def basket_params
    params.require(:basket).permit( :basket_action, data: [:item_id, :quantity])
  end

  def set_basket
    @basket = current_user.basket
  end

  def set_books
    @books = Book.books_in_basket(@basket)
  end

  def prepare_show
    set_basket; set_books
  end

  def create
    @basket = Basket.create!(user: current_user)
  end

  def ensure_basket_exists
    create unless current_user.basket 
  end

  def has_empty_basket
    if current_user.has_empty_basket?
      render_message('basket_already_empty')
    end
  end

  def validate_update_actions
    is_valid_action = Basket::VALID_ACTIONS.include?(basket_params[:basket_action])
    render_message('invalid_action') unless is_valid_action
  end

  def render_message(message, status = :unprocessable_entity)
    @message = message
    render :error_message, status: status
  end
end