class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

has_one_attached :profile_image
has_many :books, dependent: :destroy
has_many :favorites, dependent: :destroy
has_many :book_comments, dependent: :destroy



has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
has_many :followers, through: :reverse_of_relationships, source: :follower



has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
has_many :followings, through: :relationships, source: :followed





  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }


def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
end


end


