class MoviesController < ApplicationController
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #debugger
    @all_ratings = Movie.all_ratings
    @selected = @all_ratings
    
    #how to connect an instance variable to a class vairable?
    if params[:ratings]
      #this is not working
      #accessing the ratings hash rails created out of the tag buttons
      Movie.selected= params[:ratings].keys
      @selected= Movie.selected
      #params[:ratings].keys
      #print "Movie.selected\n"
      #print Movie.selected
      #print "\n @selected \n"
      #print @selected
      #create a code that makes the ones selected checked
    #else
      #Movie.selected = Movie.all_ratings
     # @selected = Movie.selected
      #@selected = Movie.all_ratings
    end
    
    #@filtered = Movie.where(:rating => @selected)
    if params[:order]
      # how to make it just selected the already selected movies
      #
      #print "\n Movie.selected\n"
      #print Movie.selected
      @movies = Movie.find(:all, :order => params[:order]+" ASC", :conditions => {:rating => Movie.selected})
      #@movies = @filtered.order(params[:order]+" ASC").all
      #, :conditions => {:rating => Movie.selected})
      #I don't like this code, it's repetitve 
      if params[:order] == "title"
        @classtitle = "hilite"
      elsif params[:order] == "release_date"
        @classrelease_date = "hilite"
      end
    else
      @movies = Movie.find(:all, :conditions => {:rating => Movie.selected})
    end
    #@selected = Movie.selected
  end

  def new
    # default: render 'new' template
  end

  def create
    print params[:movie]
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
