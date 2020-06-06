class Post < ApplicationRecord
  belongs_to :member
  validates :body, presence: true, length: { minimum: 4 }
end
