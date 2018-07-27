class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }

  validates_attachment_content_type :avatar, content_type: %r{\Aimage\/.*\z}
  validates_attachment :avatar, size: { in: 0..3.megabytes }

  validates :name, :surname, presence: true
  validates :name, :surname, length: { in: 3..80 }

  belongs_to :profession, optional: true
  has_many :comments, dependent: :destroy
  has_many :created_problems, foreign_key: :creator_id, class_name: 'Problem', inverse_of: :users
  has_many :problem_users
  has_many :problems, through: :problem_users, dependent: :destroy

  after_create :random_avatar, if: :no_avatar

  def full_name
    "#{name} #{surname}"
  end

  private

  # generates default (Gmail-alike) avater
  def random_avatar
    file = Tempfile.new([full_name, '.jpg'])
    file.binmode
    file.write(Avatarly.generate_avatar(name, format: 'jpg', size: 300))
    file.read
    begin
      self.avatar = File.open(file.path)
    ensure
      file.close
      file.unlink
    end
    save
  end

  # checks if avatar was set by user
  def no_avatar
    avatar_file_name.nil?
  end
end
