class Borrowee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :products, dependent: :destroy
  validates :name,  presence: true, length: { maximum: 50 }
 	validates :email, presence: true, uniqueness: true
  validates :phone, presence: true, numericality: true, length: {is: 10}, uniqueness: true
end
