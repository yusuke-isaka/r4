json.array!(@posts) do |post|
  json.extract! post, :id, :title, :content, :thumbnail, :created_by, :updated_by, :
  json.url post_url(post, format: :json)
end
