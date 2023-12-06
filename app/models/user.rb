class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :ingredients, dependent: :destroy
  has_many :cookbooks

  after_create :create_default_cookbook


  def create_default_cookbook
    self.cookbooks.create
  end
end
