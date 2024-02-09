class User < ApplicationRecord
  include Searchable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  has_many :books, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :access_records

  # class_nameを用いてRelationshipの方向性（送る／送られる）を明確化する。
  # このユーザーは、フォローを送る（follow_relationships）と、Relationshipの送り元のID（sender_id）に紐づけられます。
  has_many :follow_relationships, class_name: "Relationship", foreign_key: :sender_id, dependent: :destroy
  # このユーザーは、フォローを送られる（followed_relationships）と、Relationshipの送り先のID（recipient_id）に紐づけられます。
  has_many :followed_relationships, class_name: "Relationship", foreign_key: :recipient_id, dependent: :destroy
  # このユーザーのフォローユーザー（following）は、ユーザーがフォローを送った（follow_relationships）送り先（recipient）です。
  has_many :following, through: :follow_relationships, source: :recipient
  # このユーザーのフォロワー（follower）は、ユーザーがフォローを送られた（followed_relationships）送り元（sender）です。
  has_many :follower, through: :followed_relationships, source: :sender

  has_many :send_message_relationships, class_name: "DirectMessage", foreign_key: :sender_id, dependent: :destroy
  has_many :receive_message_relationships, class_name: "DirectMessage", foreign_key: :recipient_id, dependent: :destroy

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def followed_by?(user)
    followed_relationships.exists?(sender_id: user.id)
  end

  def post_count(period)
    books.where(created_at: period).count
  end

  def post_comparison(period1, period2)

    result = post_count(period1) - post_count(period2)
    if result > 0
      return "+" + result.to_s
    elsif result == 0
      return "±" + result.to_s
    else
      return result.to_s
    end


  end

end
