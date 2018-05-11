class User < ApplicationRecord
  has_many :created_events, foreign_key: "creator_id",
                            class_name: "Event",
                            dependent: :destroy

  has_many :attendances, dependent: :destroy
  has_many :attended_events, through: :attendances,
                            source: :event

  has_secure_password
  validates :name, :email, presence: true
  validates :password, length: { minimum: 5 }, allow_nil: true
end
