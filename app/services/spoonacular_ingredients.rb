class SpoonacularService
  include HTTParty
  base_uri 'https://api.spoonacular.com'

  def self.search_recipes(query)
    api_key = Figaro.env.spoonacular_api_key
    response = get("/recipes/search", query: { query: query, apiKey: api_key })
    response.parsed_response
  end
end
