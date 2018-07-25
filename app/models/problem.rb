class Problem < ApplicationRecord
  validates :title, :content, :references, presence: true
  validates :title, length: { in: 5..80 }
  validates :content, :references, length: { in: 5..500 }
  belongs_to :creator, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :problem_users, inverse_of: :problem
  has_many :users, through: :problem_users, dependent: :destroy
  has_many :problem_tags
  has_many :tags, through: :problem_tags, dependent: :destroy
  accepts_nested_attributes_for :problem_users

  scope :default_search, ->(query) { where('title LIKE ? OR content LIKE ?', "%#{query}%", "%#{query}%") }
  scope :tag_where, ->(tag_name) { joins(:tags).merge(Tag.where(name: tag_name)) }
  scope :content_where, ->(query) { where('content LIKE ?', "%#{query}%") }
  scope :title_where, ->(query) { where('title LIKE ?', "%#{query}%") }

  def current_user_contributor?(user)
    if user.nil?
      false
    elsif users.exists?(id: user.id)
      true
    end
  end

  def creator?(user)
    if user.nil? || user.id != creator.id
      false
    else
      true
    end
  end
end
