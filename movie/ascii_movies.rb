require 'imdb'
require 'pry'
require 'matrix'

class Movies
	def initialize
		@movie_titles= []
		@movies_result =[]
		
	end

	def get_movies(file_name)
		IO.foreach(file_name) do |line|
			@movie_titles<<line
		end
		@rating_matrix =Matrix.build(10,@movie_titles.length) {" "}
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
		i = 0
		while (i < (@rating_matrix.row_count-1))
			matrix_row = @rating_matrix.row(i)
			matrix_row.each {|variable| print "|#{variable}"}
			puts "|"
			i +=1	
		end
		print "|"
		print (1..@movie_titles.length).to_a.join("|")
		puts "|"
	end

	def print_movie_titles
		@movie_titles.each_with_index {|value,key| puts "#{key+1}. #{value}"}
	end
	
	def get_rating
		ind = 0
		@movies_result.each do |movie|
			rating = movie.rating.round
			
			row = 9
			rating.times do 
				@rating_matrix[row,ind] = "#"
				row -=1
			end
			ind+=1
		end
	end
end

class RatingsDisplay
	def initialize(movies)
		@movies =movies
	end

	def show_ratings

	end

	def show_titles

	end

end

class Matrix
  def []=(i, j, x)
    @rows[i][j] = x
  end
end
 
my_movies = Movies.new
my_movies.get_movies("movies.txt")
my_movies.create_movie_results
my_movies.get_rating
my_movies.print_ratings
my_movies.print_movie_titles