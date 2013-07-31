class MoviesController < ApplicationController
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    #when to clear the session? after redirect? 
    #how to connect an instance variable to a class vairable?
    if params[:ratings]
      #this is not working
      #accessing the ratings hash rails created out of the tag buttons
      Movie.selected= params[:ratings].keys
      @selected= Movie.selected
      session[:selected] = {}
      @selected.each do |ele|
        session[:selected][ele] = 1
      end
      #@selected = ["G", "R", "PG", "PG-13"]
      #create a code that makes the ones selected checked
    else
      #Movie.selected = Movie.all_ratings
      @selected = Movie.selected
      #@selected = ["G", "R", "PG", "PG-13"]
    end
    #save the array of selected rating in the session hash
    
    
    if params[:order]
      #save the sorting parameters in the session hash
      session[:order] = params[:order]
      @movies = Movie.find(:all, :order => session[:order]+" ASC", :conditions => {:rating => @selected})
      #or session[:selected].keys instead of @selected
      #change class of cell so color can change in css 
      if session[:order] == "title"
        @classtitle = "hilite"
      elsif session[:order] == "release_date"
        @classrelease_date = "hilite"
      end
      #how to make it just selected the already selected movies
      #@movies = Movie.find(:all, :order => params[:order]+" ASC", :conditions => {:rating => Movie.selected})
    elsif session[:order]
      @movies = Movie.find(:all, :order => session[:order]+" ASC", :conditions => {:rating => @selected})
      #or session[:selected].keys instead of @selected
      #change class of cell so color can change in css 
      if session[:order] == "title"
        @classtitle = "hilite"
      elsif session[:order] == "release_date"
        @classrelease_date = "hilite"
      end
      # redirect here then clear the session

      #from selected you have to make a hash with 1 value no?
      #it infintly redirects if here
      redirect_to(movies_path(:ratings => session[:selected], :order => session[:order]))
      session.clear

      # remember to preserve flash stuff
    
    else
      #changed Movie.selected to session[:selected]
      @movies = Movie.find(:all, :conditions => {:rating => @selected})
      #redirect here as well? and clear session
      #redirect_to movies_path, :ratings => session[:selected]
      #session.clear
    end
    
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
