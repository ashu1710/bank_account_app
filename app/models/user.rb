class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #relationship
  has_one :account, dependent: :destroy
  has_many :cards, dependent: :destroy
  accepts_nested_attributes_for :account

end
