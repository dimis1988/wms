class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :orders, dependent: :destroy
  default_scope { order('created_at DESC')}
  
  def full_name
    "#{first_name.capitalize}  #{last_name.capitalize}"
  end
end
