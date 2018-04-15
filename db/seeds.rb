require 'csv'

class Seed
  def self.start
    CSV.foreach("./data/movies.csv", headers: true, header_converters: :symbol) do |row|
      movie = Movie.create!(
        title: row[:title],
        description: row[:description],
        director: Director.find_or_create_by(name: row[:director])
      )
      puts "Created #{movie.title}."
    end
  end
end

Seed.start
