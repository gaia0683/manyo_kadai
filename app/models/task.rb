class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  scope :search, ->(name,status) do
    where("name LIKE ?", "%#{name}%").where("status LIKE ?", "#{status}")
  end
  scope :search_name, ->(name) do
    where("name LIKE ?", "%#{name}%" )
  end
  scope :search_status, ->(status) do
    where("status LIKE ?","#{status}")
  end
  enum status:{
    未着手:'未着手',
    着手中:'着手中',
    完了:'完了'
  }
end
