class Problem < ApplicationRecord
  validates :title, :content, :reference_list, presence: true
  validates :title, length: { in: 5..80 }
  validates :content, :reference_list, length: { in: 5..500 }
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
  scope :reference_where, ->(query) { where('reference_list LIKE ?', "%#{query}%") }

  scope :order_title_desc, -> { order(title: :desc) }
  scope :order_title_asc, -> { order(title: :asc) }
  scope :order_content_desc, -> { order(content: :desc) }
  scope :order_content_asc, -> { order(content: :asc) }
  scope :updated_at_desc, -> { order(updated_at: :desc) }
  scope :updated_at_asc, -> { order(updated_at: :asc) }

  def current_user_contributor?(user)
    if user.nil?
      false
    elsif users.exists?(id: user.id)
      true
    end
  end

  def creator?(user)
    if user.nil? || creator.nil? || user.id != creator.id
      false
    else
      true
    end
  end
end
