class Relationship < ApplicationRecord

  belongs_to :follower, class_name: "User"


  belongs_to :followed, class_name: "User"

  #userモデルの中にfollowerモデルとfollowedモデルが存在するイメージ
  #一般的に中間テーブルはuserとbook等の異なるテーブルで多対多の時に作成する。
  #今回はuserとuserで中間テーブルを作成しないといけないので、userの中でfollowerとfollowedで区別するしかない。

  # フォロー機能は「同じテーブル同士を結ぶ必要がある」
  # フォローするのもされるのも「ユーザー」になる。
  # その為、少なくとも片方は「user_id」以外のカラム名にする必要がある。
  # relationshipsテーブルに、
  # 「follower_id」フォローするユーザのid
  # 「followed_id」フォローされるユーザのid
  # で作成する。

  # 普通、外部キーとテーブル名は一致していないといけない
  # 各テーブルを、
  # 「followerテーブル」＝「follower_id」
  # 「followedテーブル」＝「followed_id」
  # とする。



end


# belongs_to :follower
# これでは、followersテーブルを参照しにいってしまう為、エラーになる。

# belongs_to :follower, class_name: "USer"
# これにより、正しくusersテーブルを参照しにいく。
# 逆にuser.rbのhas_manyでも、同様に特別な書き方をしている。
