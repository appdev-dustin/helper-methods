class MoviesController < ApplicationController
  def new
    @movie = Movie.new

  end

  def index
    @movies = Movie.all.order(created_at: :desc )

    respond_to do |format|
      format.json do
        render json: @list_of_movies
      end

      format.html
    end
  end

  def show
    #the_id = params.fetch(:id)

    #matching_movies = Movie.where({:id:> the_id)

    #@movie = matching_movies.first

    @movie = Movie.find(params.fetch(:id))
  end

  def create
    @movie = Movie.new(params.require(:movie).permit(:title, :description))


    if @movie.valid?
      @movie.save
      redirect_to(movies_url, notice: "Movie created successfully." )
    else
      render "new"
    end
  end

  def edit

    @movie = Movie.find(params.fetch(:id))
  end

  def update
    the_movie = Movie.find(params.fetch(:id))

    the_movie.title = params.fetch(:title)
    the_movie.description = params.fetch(:title)

    if the_movie.valid?
      the_movie.save
      redirect_to movie_url(the_movie), notice: "Movie updated successfully."
    else
      redirect_to movie_url(the_movie), alert: "Movie failed to update successfully."
    end
  end

  def destroy
    the_movie = Movie.find(params.fetch(:id))

    the_movie.destroy

    redirect_to movies_url, notice: "Movie deleted successfully." 
  end
end
