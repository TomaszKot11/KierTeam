class Problem < ApplicationRecord
    validates :title, :content, :references, presence: true
    validates :title, length: { in: 5..80 }
    validates :content,:references, length: { in: 5..500 }

    belongs_to :creator, class_name: 'User'

    has_many :comments, dependent: :destroy

    has_many :problem_users, inverse_of: :problem
    has_many :users, through: :problem_users

    has_many :problem_tags
    has_many :tags, through: :problem_tags

    accepts_nested_attributes_for :problem_users

    # checks whether the current logged user is contributor to showed 
    # problem and can add comments
    def current_user_contributor?
      contributors = @problem.users
        if @current_user.nil?
          return false
        else 
          return @contributors.inlude?(current_user)
        end
    end

    # checks if current logged in user is creator of given problem
    def creator?
      return false if current_user.nil?
      return true if (  current_user.id == self.creator_id )
      false 
    end

end
