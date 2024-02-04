class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  #同一の中継先（Relationship）を:active_relationshipsと:passive_relationships（名前は任意）に分け、中継先の参照するキー名をforeign_keyで指定
  #このユーザー"が"フォローする人
  has_many :active_relationships, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy
  #このユーザー"を"フォローする人
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  #:relationshipの中継先のユーザーを:followed、:followerに集める
  #:followedで、active_relationships（Relationship）のユーザーをフォローしている対象（belongs_toの項目 => :follower）の一覧を取得
  has_many :followed, through: :active_relationships, source: :follower
  #:followerで、passive_relationships（Relationship）のユーザーがフォローしている対象（belongs_toの項目 => :followed）の一覧を取得
  has_many :follower, through: :passive_relationships, source: :followed

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def followed_by?(user)
    passive_relationships.find_by(followed_id: user.id).present?
  end
end
