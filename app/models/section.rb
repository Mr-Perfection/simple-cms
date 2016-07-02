class Section < ActiveRecord::Base
	belongs_to :page
	has_many :section_edits
	has_many :editors, :through => :section_edits, :class_name => "AdminUser"
	CONENT_TYPES = ['text', 'HTML']
	
	acts_as_list :scope => :page
	after_save :touch_page

	validates_presence_of :name
	validates_length_of :name, :maximum => 255
	validates_inclusion_of :content_type, :in => ['text', 'HTML'],
		:message => "must be one of: #{CONENT_TYPES.join(',')}"
	validates_presence_of :content



	scope :visible, lambda{ where(:visible => true)}
	scope :invisible, lambda{ where(:visible => false)}
	scope :sorted, lambda{ order("sections.position ASC")}
	scope :newest_first,  lambda {order("sections.created_at DESC")}

	private
	def touch_page
		# touch is similar to:
		# page.update_attribute(:update_at, Time.now)
		page.touch
	end
	

end
