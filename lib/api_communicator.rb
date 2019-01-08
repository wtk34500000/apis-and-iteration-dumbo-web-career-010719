require 'rest-client'
require 'json'
require 'pry'

def parseUrl(urls)
  result=[]
  for url in urls
    result.push(JSON.parse(RestClient.get(url)))
  end
  return result
end

def movieInfo(movie_name)
  response_string = RestClient.get('http://www.swapi.co/api/films/')
  response_hash = JSON.parse(response_string)
  puts response_hash["results"].find {|film| film["title"].downcase == movie_name.downcase}
end

def into_hash(url)
  response_string = RestClient.get(url)
  response_hash = JSON.parse(response_string)
  return response_hash
end


def get_character_movies_from_api(character_name)
  #make the web request
  # response_string = RestClient.get('http://www.swapi.co/api/people/')
  # response_hash = JSON.parse(response_string)
  temp_page="https://swapi.co/api/people/?page=1"
  array=[]

  
  while temp_page != nil
       result=into_hash(temp_page)
       array.concat(result["results"])
       temp_page=result["next"]
  end
  
  #binding.pry
   urls=array.find {|item| item["name"].downcase == character_name}["films"]
  

  # funciton
  # urls.may 
  # puts response_hash["results"][films].find()[title]
   parseUrl(urls)
  #binding.pry

  
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end



def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films.each do |film|
    puts film["title"]
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
