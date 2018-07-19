class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # , :confirmable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :name, :surname, :position, presence: true
  validates :name, :surname, :position, length: {in: 3..80}
  
  has_many :created_problems, foreign_key: :creator_id, class_name: 'Problem'

  has_many :problem_users
  has_many :problems, through: :problem_users
  has_many :comments


end

