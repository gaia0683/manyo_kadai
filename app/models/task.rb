class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  scope :search, ->(name,status) do
    where("name LIKE ?", "%#{name}%").where(status: status)
  end
  scope :search_name, ->(name) do
    where("name LIKE ?", "%#{name}%" )
  end
  scope :search_status, ->(status) do
    where(status: status)
  end
  enum status:{
    未着手:0,
    着手中:1,
    完了:2
  }
  enum rank:{
    高:2,
    中:1,
    低:0
  }
  belongs_to :user
end
