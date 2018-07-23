class Problem < ApplicationRecord
  validates :title, :content, :references, presence: true
  validates :title, length: { in: 5..80 }
  validates :content, :references, length: { in: 5..500 }
  belongs_to :creator, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :problem_users, inverse_of: :problem
  has_many :users, through: :problem_users, dependent: :destroy
  has_many :problem_tags
  has_many :tags, through: :problem_tags
  accepts_nested_attributes_for :problem_users

  def current_user_contributor?(user)
    if user.nil?
      false
    elsif self.users.exists?(:id => user.id)
      true
    end
  end

  def creator?(user)
    if user.nil? || user.id != self.creator.id
      false
    else
      true
    end
  end
end
