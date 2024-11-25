class Message < ApplicationRecord
  belongs_to :user  # 修改 author 为 user
  has_many :comments

  validates :content, presence: true
end
