class ReviewSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description, :score, :meme_id
end
