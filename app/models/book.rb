class Book < ApplicationRecord

  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true
  validates :body, length: { maximum: 200 }

  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy



end
