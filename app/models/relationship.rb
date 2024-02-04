class Relationship < ApplicationRecord

  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"

  validates :sender, uniqueness: { scope: :recipient }

end
