class User < ApplicationRecord
  # for user authentication
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  # for avatars
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }
  # TODO: restrict this to jpg jpeg png gif :) 
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates_attachment :avatar, size: {in: 0..3.megabytes}

  validates :name, :surname, :position, presence: true
  validates :name, :surname, :position, length: {in: 3..80}
  
  has_many :created_problems, foreign_key: :creator_id, class_name: 'Probleclear'

  has_many :problem_users
  has_many :problems, through: :problem_users
  has_many :comments

  def fullname
      "#{name} #{surname}"
  end  
end

