json.articles decorate_collection(@articles, LocalizedArticle) do |article|
  json.published_on article.published_on
  json.title article.title
end
