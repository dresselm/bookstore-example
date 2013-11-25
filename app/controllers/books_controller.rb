class BooksController < ApplicationController
  def index
    if params[:query].present?
      @books = Book.search(params[:query], page: params[:page])
    else
      @books = Book.all.page params[:page]
    end
  end

  def autocomplete
    render json: Book.search(params[:query], autocomplete: true, limit: 10).map(&:title)
  end

  def import
    olid = params[:olid]
    book = Book.import(olid)
    redirect_to new_book_path, notice: "Imported #{book.title}"
  rescue Book::ImportError
    redirect_to new_book_path, alert: "Failed to import book: #{olid}"
  end
end
