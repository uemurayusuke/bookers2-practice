class Relationship < ApplicationRecord

  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  #userモデルの中にfollowerモデルとfollowedモデルが存在するイメージ
  #一般的に中間テーブルはuserとbook等の異なるテーブルで多対多の時に作成する。
  #今回はuserとuserで中間テーブルを作成しないといけないので、userの中でfollowerとfollowedで区別するしかない。


end
