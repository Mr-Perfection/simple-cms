class AdminUser < ActiveRecord::Base
	# Configure a different table name
	# self.table_name = "admin_users"

	has_secure_password
	has_and_belongs_to_many :pages
	has_many :section_edits
	has_many :sections, :through => :section_edits
	

	# email format
	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	FORBIDDEN_USERNAMES = ['littleboobs', 'penis', 'gay']
	# Validations
	# validates_presence_of :first_name
	# validates_length_of :first_name, :maximum => 25
	# validates_presence_of :last_name
	# validates_length_of :last_name, :maximum => 50
	# validates_presence_of :username
	# validates_length_of :username, :within => 8...25
	# validates_uniqueness_of :username
	# validates_presence_of :email
	# validates_length_of :email, :maximum => 100
	# validates_format_of :email, :with => EMAIL_REGEX
	# validates_confirmation_of :email


	#Shortcut validations, aka "Sexy Validations"
	validates :first_name, :presence => true,
							:length => {:maximum => 25}
	validates :last_name, :presence => true,
							:length => {:maximum => 50}
	validates :username, :length => {:within => 8..25},
							:uniqueness => true
	validates :email, :presence => true,
	:length => {:maximum => 50,
		:format => EMAIL_REGEX,
		:confirmation => true}	

	validate :username_is_allowed
	#validate :no_new_users_on_saturday, :on => :create
	def username_is_allowed
		if FORBIDDEN_USERNAMES.include?(username)
		errors.add(:username, "has been restricted from use.")	
		end 	
	end					

	#Errors not related to a specific attribute
	#can be added to errors[:base]
	def no_new_users_on_saturday
		if Time.now.wday == 6
			errors[:base] << "No new users on Saturdays."
		end
	end

	#return the full name ([firstname] [lastname])
	def name
		"#{first_name} #{last_name}"
	end

	# Scopes
	scope :sorted, lambda{order("admin_users.last_name ASC ,admin_users.first_name ASC")} 
	
end
