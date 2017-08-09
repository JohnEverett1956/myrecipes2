class Message < ApplicationRecord
  validates :content, presence: true, length: {minimum: 5, maximum: 500}
  belongs_to :chef
  validates :chef_id, presence: true
  
  def self.most_recent
    order(:created_at).last(20)
  end
end