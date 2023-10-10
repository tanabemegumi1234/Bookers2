class BooksController < ApplicationController

  before_action :authenticate_user!

  before_action :correct_user, only: [:edit, :update]

  def create
    @book = Book.new(books_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
    	redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end

  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user

  end

  def show
    @book = Book.find(params[:id])
    @newbook = Book.new
    @user = @book.user
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      flash[:notice] = "Book was successfully destroyed"
      redirect_to books_path
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(books_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render action: :edit
    end
  end

  private
    def correct_user
      @book = Book.find(params[:id])
      if current_user.id != @book.user.id
        redirect_to books_path
      end
    end

    def books_params
      params.require(:book).permit(:title, :body)
    end

end