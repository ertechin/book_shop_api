class Basket < ApplicationRecord
  belongs_to :user
  validates :user, presence: true

  VALID_ACTIONS = %w[remove_item update_item_quantity add_item].freeze

  # TODO: look params
  # TODO: integer mi

  def item_ids
    data.keys
  end

  def total_price(items)
    items.sum do |item|
      data[item.id.to_s]['quantity'].to_i * item.price
    end
  end

  def item_exist?(item_id)
    data.has_key?(item_id)
  end

  def value_positive?(quantity)
    quantity.to_i.positive?
  end

  def update_logic(params)
    state, message = validate_before_update_logic(params)
    return state, message unless state

    send(params[:basket_action], params[:data])
  end

  def add_item(params)
    validate_and_save(params, :validate_before_add_item) do
      data.merge!(basket_structure(params[:item_id], params[:quantity]))
    end
  end

  def remove_item(params)
    validate_and_save(params, :validate_before_remove_item) do
      data.delete(params[:item_id])
    end
  end

  def update_item_quantity(params)
    validate_and_save(params, :validate_before_update_item_quantity) do
      data[params[:item_id]][:quantity] = params[:quantity]
    end
  end

  private

  def basket_structure(item_id, quantity)
    { item_id => { quantity:} }
  end

  def full_error_message
    errors.full_messages.join(', ')
  end

  def validate_and_save(params, validation_method, &block)
    state, message = send(validation_method, params)
    return state, message unless state

    block.call
    save ? true : [false, full_error_message]
  end

  def validate_before_update_logic(params)
    return false, 'data_cant_empty' if params[:data].empty?
    return false, 'item_id_cant_nil' if params[:data][:item_id].nil?
    return false, 'item_id_cant_blank' if params[:data][:item_id].blank?
    true
  end

  def validate_before_add_item(params)
    return false, 'item_exists' if item_exist?(params[:item_id])
    return false, 'quantity_must_positive' unless value_positive?(params[:quantity])
    true
  end

  def validate_before_remove_item(params)
    return false, 'item_not_exists' unless item_exist?(params[:item_id])
    true
  end

  def validate_before_update_item_quantity(params)
    return false, 'item_not_exists' unless item_exist?(params[:item_id])
    return false, 'quantity_must_positive' unless value_positive?(params[:quantity])
    true
  end
end