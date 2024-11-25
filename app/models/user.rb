class User < ApplicationRecord
  validates :name, presence: true
  has_many :messages
  has_many :comments
end
