class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :content, presence: true,
            length: { minimum: 1, message: "Comment cannot be empty" }

end