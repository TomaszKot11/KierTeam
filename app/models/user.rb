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
  
  has_many :comments, dependent: :destroy
  has_many :created_problems, foreign_key: :creator_id, class_name: 'Problem', dependent: :destroy
  has_many :problem_users
  has_many :problems, through: :problem_users

  after_create :random_avatar, if: :no_avatar

  def full_name
      "#{name} #{surname}"
  end 
  
  private 
    # generates default (Gmail-alike) avater 
    def random_avatar
      file = Tempfile.new([self.fullname, ".jpg"])
      file.binmode
      file.write(Avatarly.generate_avatar(self.name, format: "jpg", size: 300))
      file.read 
      begin
        self.avatar = File.open(file.path)
      ensure
        file.close
        file.unlink
      end
      self.save 
    end

    # checks if avatar was set by user 
    def no_avatar
      self.avatar_file_name.nil?
    end
end

