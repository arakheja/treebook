class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :profile_name, :avatar
  # attr_accessible :title, :body

  validates :first_name, presence: true, length: { :maximum => 50 }

  validates :last_name, presence: true, length: { :maximum => 50 }

  validates :email, presence: true, uniqueness: true

  validates :profile_name, presence: true, 
            uniqueness: true,
            format: {
              with: /\A[a-zA-Z0-9_-]+\z/,
              message: 'Must be formatted correctly.'
            }

  # validates :age, presence: true, length: '> 13' or something similar

  has_many :activities
  has_many :albums
  has_many :pictures
  has_many :statuses
  has_many :user_friendships
  has_many :friends, through: :user_friendships,
                              conditions: { user_friendships: { state: 'accepted' } }

  has_many :pending_user_friendships, class_name: 'UserFriendship',
                                      foreign_key: :user_id,
                                      conditions: { state: 'pending' }
  has_many :pending_friends, through: :pending_user_friendships, source: :friend
  
  has_many :requested_user_friendships, class_name: 'UserFriendship',
                                      foreign_key: :user_id,
                                      conditions: { state: 'requested' }
  has_many :requested_friends, through: :requested_user_friendships, source: :friend
  
  has_many :blocked_user_friendships, class_name: 'UserFriendship',
                                      foreign_key: :user_id,
                                      conditions: { state: 'blocked' }
  has_many :blocked_friends, through: :blocked_user_friendships, source: :friend
  
  has_many :accepted_user_friendships, class_name: 'UserFriendship',
                                      foreign_key: :user_id,
                                      conditions: { state: 'accepted' }
  has_many :accepted_friends, through: :accepted_user_friendships, source: :friend

  # If changing styles, also change in picture model and do the rake task to clean up
  has_attached_file :avatar, styles: {
    large: "800x800>", medium: "300x200>", small: "260x180>", thumb: "80x80#"
  }
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  def default_avatar_feed
    "Avatar-default-thumb.png"
  end
  def default_avatar_menu
    "Avatar-default.png"
  end

  # Remove this when setting default avatars and the associated rake task
  #def self.get_gravatars
  #  all.each do |user|
  #    if !user.avatar?
  #      # user.avatar = URI.parse(user.gravatar_url)
  #      user.avatar = 'images/avatar.png'
  #      user.save
  #      print "."
  #    end
  #  end
  #end
  #URI.prase tells paperclip to fetch a URI instead of the returned string

  def full_name
  	first_name + " " + last_name
  end

  #to param method helps when link to various locations
  def to_param
    profile_name
  end

  #overriding the to_string method helps us properly show first name in the string of the breadcrumbs
  def to_s
    first_name
  end

  def gravatar_url
    stripped_email = email.strip
    downcased_email = stripped_email.downcase
    hash = Digest::MD5.hexdigest(downcased_email)

    "http://gravatar.com/avatar/#{hash}"
  #strip removes any unneeded space
  end

  def has_blocked?(other_user)
    blocked_friends.include?(other_user)
  end

  def create_activity(item, action)
    # This will be scoped automatically to the user instance
    activity = activities.new
    activity.targetable = item
    activity.action = action
    activity.save
    # The create_activity method returns the actual activity instance
    activity
  end
  
end
