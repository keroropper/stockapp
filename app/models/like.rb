class Like < ApplicationRecord
  belongs_to :user
  belongs_to :article#, counter_cache: :like_count  #counter_cahce: :likes_countはリレーションされているlikeの数の値をリレーション先のlikes_countというカラムの値に入れる

  validates :user_id, presence: true
  validates :article_id, presence: true
  validates_uniqueness_of :article_id, scope: :user_id #user_idとarticle_idが一致した時にuniquenessのバリデーションがかかる。
end
