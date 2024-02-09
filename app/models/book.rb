class Book < ApplicationRecord
  include Searchable
  include Scope

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :access_records, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length:{ maximum: 200 }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def total_access_count
    access_records.pluck(:count).sum
  end

  def self.trend
    self.all.sort_by { |book| -book.favorites.created_while("this_week").count }
  end

end
