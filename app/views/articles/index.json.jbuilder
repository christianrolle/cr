json.articles @articles do |article|
  json.published_at article.published_at
  json.title article.title
end
