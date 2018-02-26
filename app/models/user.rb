class User < ActiveRecord::Base
  has_secure_password
  has_many :secrets
  has_many :likes, dependent: :destroy
  has_many :secrets_liked, through: :likes, source: :secret	

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
    validates :name, :email, :password, :presence => true 
    validates :name, :length =>  { :minimum => 2 } 
    #validates :email, :format { with: EMAIL_REGEX }
    validates :email, :uniqueness => true

    # this callback will run before saving on create and update
    # before_save :downcase_email
  
    # this callback will run after creating a new user
    after_create :successfully_created
  
    # this callback will run after updating an existing user
    after_update :successfully_updated

    private
    def downcase_email
      self.email.downcase!
    end
    
    def successfully_created
      puts "Successfully created a new user"
    end

    def successfully_updated
      puts "Successfully updated an existing user"
    end
end
