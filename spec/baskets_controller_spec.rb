# spec/controllers/baskets_controller_spec.rb
require 'rails_helper'

RSpec.describe BasketsController, type: :controller do
  render_views

  before do
    User.destroy_all
    Basket.destroy_all
    Book.destroy_all
  end

  let(:user) { FactoryBot.create(:user, email: Faker::Internet.unique.email) }
  let(:book) { FactoryBot.create(:book) }

  before do
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, format: :json
      json_response = JSON.parse(response.body)
      expect(response).to be_successful
      expect(json_response['basket']['books']).to be_empty
      expect(json_response['basket']['total_price']).to eq(0)
    end
  end

  describe "Post #update_item_quantity" do
    let(:basket) { FactoryBot.create(:basket, user: user, data: ({ book.id => {quantity: "1"} })) }
    it "updates the requested basket" do
      basket.reload
      post :update, format: :json, body: {
        basket: {
          data: {
            item_id: "#{book.id}",
            quantity: "100"
          },
          basket_action: "update_item_quantity"
        }
      }.to_json, as: :json
      json_response = JSON.parse(response.body)
      basket.reload
      expect(json_response['basket']).not_to be_empty
      expect(json_response['basket']['total_price']).to eq(1200)
    end
  end

  describe "Post #add_item" do
    it "updates the requested basket" do
      post :update, format: :json, body: {
        basket: {
          data: {
            item_id: "#{book.id}",
            quantity: "1"
          },
          basket_action: "add_item"
        }
      }.to_json, as: :json
      json_response = JSON.parse(response.body)
      book.reload
      expect(json_response['basket']).not_to be_empty
      expect(json_response['basket']['total_price']).to eq(12)
    end
  end

  describe "Post #remove_item" do
  let(:basket) { FactoryBot.create(:basket, user: user, data: ({ book.id => {quantity: "1"} })) }
  it "updates the requested basket" do
    user.reload
    basket.reload
    post :update, format: :json, body: {
      basket: {
        data: {
          item_id: "#{book.id}",
        },
        basket_action: "remove_item"
      }
    }.to_json, as: :json
    json_response = JSON.parse(response.body)
    expect(json_response['basket']['books']).to be_empty
    expect(json_response['basket']['total_price']).to eq(0)
  end

  describe "Post #clear" do
    let(:basket) { FactoryBot.create(:basket, user: user, data: ({ book.id => {quantity: "1"} })) }
    it "clears the basket" do
      user.reload
      basket.reload
      post :clear, format: :json
      json_response = JSON.parse(response.body)
      expect(json_response['basket']['books']).to be_empty
      expect(json_response['basket']['total_price']).to eq(0)
    end
  end
end
end