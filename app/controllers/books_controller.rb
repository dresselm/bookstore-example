class BooksController < ApplicationController
  def index
    if params[:query].present?
      @books = Book.search(params[:query], page: params[:page])
    else
      @books = Book.all.page params[:page]
    end
  end

  def autocomplete
    book_titles  = Book.search(params[:query], autocomplete: true, limit: 10).map(&:title)
    # TODO proof of concept - may need to customize ES gem for cross-model searching
    author_names = Author.search(params[:query], autocomplete: true, limit: 10).map(&:name)

    render json: book_titles + author_names
  end

  def import
    olid = params[:olid]
    book = Book.import(olid)
    redirect_to new_book_path, notice: "Imported #{book.title}"
  rescue Book::ImportError
    redirect_to new_book_path, alert: "Failed to import book: #{olid}"
  end
end
