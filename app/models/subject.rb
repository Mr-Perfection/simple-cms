class Subject < ActiveRecord::Base


	# Could delete related pages automatically
	#whenever a subject is deleted:
	# has_many :pages, :dependent => :destroy
	has_many :pages, :dependent => :destroy
	acts_as_list
	# Dont need to validate in most cases:
	# ids, foreign keys, timestamps, booleans, counters
	validates_presence_of :name
	validates_length_of :name, {:maximum => 255}




	scope :visible, lambda{where(:visible => true)}
	scope :invisible, lambda{where(:visible => false)}
	scope :sorted, lambda{ order("subjects.position ASC")}
	scope :newest_first, lambda{order("subjects.created_at DESC")}
	scope :search, lambda{|query| where(["name LIKE ?", "%#{query}%"])}
end
