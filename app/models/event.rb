class Event < ApplicationRecord
  belongs_to :creator,    class_name: "User"
  has_many :attendances,  dependent: :destroy
  has_many :attendees,    through: :attendances,
                          source: :user
  validates :name, :description, :location, presence: true
  validate :not_in_past
  scope :future, -> { where("date_time > ?", Time.now) }
  scope :past, -> { where("date_time < ?", Time.now) }
  accepts_nested_attributes_for :attendances



  private
  def not_in_past
    if self.date_time.past?
      errors.add(:date, 'not in past')
    end
  end
end
