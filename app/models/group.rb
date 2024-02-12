class Group < ApplicationRecord

  has_one_attached :image

  has_many :group_users, dependent: :destroy
  has_many :joined_users, through: :group_users, source: :user

  validates :name, presence: true
  validates :introduction, length:{ maximum: 200 }

  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end

end
