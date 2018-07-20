class Comment < ApplicationRecord
  belongs_to :user, touch: true
  belongs_to :movie, touch: true

  validates :content, presence: true,
            length: { minimum: 1, message: "Comment cannot be empty" }

end