class Admin::GenresController < ApplicationController
before_action :authenticate_admin!, except: [:top, :about,:sign_in]
  def new
    @genre = Genre.new

  end

  def create
    @genre_new = Genre.new(genre_params)
    if @genre_new.save
      redirect_to edit_admin_genre_path(@genre_new.id)
    else
      @user = current_admin
      @genres = Genre.all
      render :index
      flash[:notice] = "ジャンルを追加に失敗しました"
    end
  end

  def index
    @genre_new = Genre.new
    @genres = Genre.all

  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    @genre.update(genre_params)
    if@genre.save
    flash[:notice] = "ジャンルを更新しました"
    redirect_to admin_genres_path
    else
      render :edit
    end
  end


  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to admin_genres_path
  end

  private

  def genre_params
    params.require(:genre).permit(:genre_name)
  end

end