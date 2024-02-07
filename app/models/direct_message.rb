class DirectMessage < ApplicationRecord

  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"

  validates :message, presence: true, length:{ maximum: 140 }

  def self.pair_of_users(a, b)
    self.where(recipient_id: a.id, sender_id: b.id).or(self.where(recipient_id: b.id, sender_id: a.id))
  end

end
