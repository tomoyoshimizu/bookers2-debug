class Book < ApplicationRecord
  include Searchable

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length:{ maximum: 200 }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.trend(books)
    period = 1.week.ago.beginning_of_day..Time.zone.now.end_of_day
    #テスト用（1時間以内）
    # period = 1.hour.ago..Time.zone.now
    books.sort_by { |book| -book.favorites.where(created_at: period).count }
  end

end
