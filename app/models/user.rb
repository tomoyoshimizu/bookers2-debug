class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  # class_nameを用いてRelationshipの方向性（送る／送られる）を明確化する。
  # このユーザーは、フォローを送る（request_follow）と、Relationshipの送り元のID（sender_id）に紐づけられます。
  has_many :request_follow, class_name: "Relationship", foreign_key: :sender_id, dependent: :destroy
  # このユーザーは、フォローを送られる（requested_follow）と、Relationshipの送り先のID（recipient_id）に紐づけられます。
  has_many :requested_follow, class_name: "Relationship", foreign_key: :recipient_id, dependent: :destroy
  # このユーザーのフォローユーザー（following）は、ユーザーがフォローを送った（request_follow）送り先（recipient）です。
  has_many :following, through: :request_follow, source: :recipient
  # このユーザーのフォロワー（follower）は、ユーザーがフォローを送られた（requested_follow）送り元（sender）です。
  has_many :follower, through: :requested_follow, source: :sender

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def followed_by?(user)
    requested_follow.find_by(sender_id: user.id).present?
  end
end
