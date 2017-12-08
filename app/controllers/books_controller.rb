class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def index
    @books = current_user.books.order('updated_at DESC')
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @chapters = @book.chapters.order('created_at')
    @chapter = Chapter.new
    @characters = @book.characters
    @character = Character.new
    @places = @book.places
    @place = Place.new
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user

    if @book.save
      redirect_to book_path(@book), alert: 'Vous avez ajouté un nouveau livre !'
    end
  end

  def statistics
    @book = Book.find(params[:book_id])

    @dwc = @book.daily_word_counts.order('created_at').last(30)
    @dwc_dates = []
    @dwc_values = []

    @dwc.each do |dwc|
      @dwc_dates << dwc.created_at.strftime('%d/%m/%Y')
      @dwc_values << dwc.wordcount
    end



  end

  private

  def book_params
    params.require(:book).permit(:title, :word_goal)
  end

end
