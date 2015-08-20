require 'imdb'

class Movies
	def initialize
		@movie_titles= []
		@movies_result = []
		@movie_ratings = []
	end

	def get_movies(file_name)
		IO.foreach(file_name) do |line|
			@movie_titles<<line
		end
	end

	def create_movie_results
		@movie_titles.each do |title|
			find_movie(title)
		end
	end

	def find_movie(title)
		movie_search = Imdb::Search.new(title)
		@movies_result.push(movie_search.movies[0])
	end

	def print_ratings
		
		10.downto(1) do |i|
		print "|"	
		@movie_ratings.each do |rating|
			if rating >= i
				print "#|"
			else
				print " |"
			end
			end
			puts ""
		end
		
		print "|"
		print (1..@movie_titles.length).to_a.join("|")
		puts "|"
	end

	def print_movie_titles
		@movie_titles.each_with_index {|value,key| puts "#{key+1}. #{value}"}
	end
	
	def get_rating
		@movies_result.each do |movie|
			@movie_ratings<<movie.rating.round
		end
	end
end

my_movies = Movies.new
my_movies.get_movies("movies.txt")
my_movies.create_movie_results
my_movies.get_rating
my_movies.print_ratings
my_movies.print_movie_titles