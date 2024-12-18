class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { admin: 0, warehouse_manager: 1, store_operator: 2 }

  # Ensure a default role is set when creating a user
  after_initialize do
    self.role ||= :store_operator if self.new_record?
  end
end
