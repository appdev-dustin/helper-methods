class DirectorsController < ApplicationController
  def new
    @director = Director.new

  end

  def index
    @directors = Director.all.order(created_at: :desc )

    respond_to do |format|
      format.json do
        render json: @directors
      end

      format.html
    end
  end

  def show
    #the_id = params.fetch(:id)

    #matching_directors = director.where({:id:> the_id)

    #@director = matching_directors.first

    @director = Director.find(params.fetch(:id))
  end

  def create
    @director = Director.new(params.require(:director).permit(:name, :bio))


    if @director.valid?
      @director.save
      redirect_to(directors_url, notice: "director created successfully." )
    else
      render "new"
    end
  end

  def edit

    @director = Director.find(params.fetch(:id))
  end

  def update
    the_director = Director.find(params.fetch(:id))

    the_director.name = params.fetch(:name)
    the_director.bio = params.fetch(:name)

    if the_director.valid?
      the_director.save
      redirect_to director_url(the_director), notice: "director updated successfully."
    else
      redirect_to director_url(the_director), alert: "director failed to update successfully."
    end
  end

  def destroy
    the_director = director.find(params.fetch(:id))

    the_director.destroy

    redirect_to directors_url, notice: "director deleted successfully." 
  end
end
