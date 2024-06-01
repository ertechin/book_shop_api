class BooksController < ApplicationController
  def index
    @books = Book.all.recently_created
    render json: @books
  end
end
