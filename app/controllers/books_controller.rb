class BooksController < ApplicationController
  def index
    @books = Book.all.recently_created
  end
end
