class User < ApplicationRecord
  include ActiveModel::Dirty
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length:{ maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  has_secure_password
  before_validation { email.downcase! }
  validates :password, length: { minimum: 6 }
  has_many :tasks, dependent: :destroy
  before_destroy :before_destroy_leave_one_admin_user
  before_update :before_update_leave_one_admin_user



  private

  def before_destroy_leave_one_admin_user
    if User.where(admin_user:true).count == 1 && admin_user == true
      throw(:abort)
    end
  end

  def before_update_leave_one_admin_user
    if User.where(admin_user:true).count == 1 && self.admin_user_change == [true,false]
      throw(:abort)
    end
  end
end
