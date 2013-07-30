class Movie < ActiveRecord::Base
	@@all_ratings = ["G", "R", "PG", "PG-13"]
	#@ or @@
	#initiall state of filtered is that ll options are selected
	@@selected = @@all_ratings
	#attr_accessor :all_ratings
	
	def self.all_ratings
		#a class method to keep track of all raitings
		#Movie.select('distinct rating').each do |movie_object|
		#	@all_ratings << movie_object.rating
		#end
		@@all_ratings
	end
	def self.selected
		@@selected
	end
	def self.selected= (arr)
		@@selected = arr
	end
end
