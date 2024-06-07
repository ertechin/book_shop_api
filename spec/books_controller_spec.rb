# spec/controllers/books_controller_spec.rb
require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  before do
  Book.destroy_all
  @book = Book.create!(title: "The Great Gatsby", author: "F. Scott Fitzgerald", price: 12)
  end
  render_views
  describe "GET #index" do
    it "returns a success response" do
      get :index, format: :json
      expect(response).to be_successful
    end

    it "returns the correct books" do
      get :index, format: :json
      json_response = JSON.parse(response.body)
      expect(json_response).not_to be_empty
      expect(json_response.first['title']).to eq(@book.title)
    end
  end
end