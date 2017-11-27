class CharactersController < ApplicationController
  def create
    @character = Character.new(character_params)
    @character.book = Book.find(params[:book_id])
    if @character.save
      redirect_to book_characters_path(@character.book), alert: "Vous avez ajouté un nouveau personnage!"
    end
  end

  def index
    @book = Book.find(params[:book_id])
    @character = Character.new
    @characters = @book.characters
    @chapters = @book.chapters
    @places = @book.places
  end

  private

  def character_params
    params.require(:character).permit(:first_name, :last_name)
  end
end