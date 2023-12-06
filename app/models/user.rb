class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :ingredients, dependent: :destroy
  has_many :cookbooks

  after_create :create_default_cookbook
  after_commit :async_update, on: [:create, :update]


  def create_default_cookbook

    self.cookbooks.create

  end

  private

  def async_update
    UpdateUserJob.perform_later(self)
  end

end
