class Book < ApplicationRecord
  include Searchable

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

  def self.trend(books)
    period = 1.week.ago.beginning_of_day..Time.now.end_of_day
    #検証用
    # period = 2.minute.ago..Time.now
    # period = 1.hour.ago..Time.now
    books.sort_by { |book| -book.favorites.where(created_at: period).count }
  end

end
