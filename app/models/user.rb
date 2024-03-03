class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

has_one_attached :profile_image
has_many :books, dependent: :destroy
has_many :favorites, dependent: :destroy
has_many :book_comments, dependent: :destroy



has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
has_many :followers, through: :reverse_of_relationships, source: :follower

#今回は、follower_idをフォローするユーザのidとしている。
#また、followed_idをフォローされるユーザのidとしている。
#relationshipの中で、revese_of_relationshipsというテーブルを作成している。
#throughとsourceの意味は、revese_of_relationshipsのfollowerカラムにアクセスするという意味。
#何がしたいかというと、Userをフォローするユーザーのリストを取得している。
#それをするために、1行目でreverse_of_relationshipsを定義している。
#まとめると、1行目で、フォローされているユーザーを取得する。つまり、フォローされているユーザーをたくさん持つっていう意味やな
#2行目で、フォローされているユーザーのフォローしているユーザーを取得する。

has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
has_many :followings, through: :relationships, source: :followed

#favoriteを例に出すと、bookモデルでも、has_manyを記述する。userモデルでもhas_manyを記述する
#一般的な記述方法なら、has_many relationshipsで終わりやねん。でも、今回はuserモデルだけでやらないといけない。
#だから、userモデルにfollowerとfollowedの2つの記述をしないといけない。
#かつhas_many relationshipsで書いてしまうと、区別ができないから、relationshipとreverse_of_relationshipを作成しないといけないという事。
#1行目のrelationshipsの中には、follower_id(ファローするユーザのid)のテーブル。
#2行目ではユーザーがフォローしているユーザーを取得する。
#後、もうちょいで理解できそうな気がするんやけどな。



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
