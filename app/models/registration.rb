class Registration < ActiveRecord::Base
  usesguid

  has_attached_file :abstract
  
  validates_attachment_content_type :abstract, :content_type => ['application/msword', 'application/pdf', 'text/plain', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'text/richtext'], :on => :create, :unless => Proc.new { |registrant| registrant.abstract_file_name.nil? }
  validates_attachment_size :abstract, :less_than => 5.megabytes, :on => :create, :unless => Proc.new { |registrant| registrant.abstract_file_name.nil? }, :message => "file must be less than 5 MB"
  
  #run some cleanup methods
  before_validation :chop_title_whitespace
  before_save :capitalize_names, :capitalize_city, :set_party_size, :set_fees
  before_update :capitalize_names, :capitalize_city
  
  #validating name
  validates_presence_of :title, :on => :create, :message => "can't be blank"
  validates_inclusion_of :title, :on => :create, :in => %w(Dr. Mr. Ms. Mrs.), :message => "%s is not available. Please choose from Dr., Mr., Ms., Mrs."
  validates_presence_of :firstname, :on => :create, :message => "can't be blank"
  validates_presence_of :lastname, :on => :create, :message => "can't be blank"
  
  #validating email
  validates_presence_of :email, :on => :create, :message => "can't be blank"
  validates_confirmation_of :email, :message => "addresses must match"
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates_uniqueness_of :email, :on => :create, :message => "already submitted; must be unique"
  
  #validating state abbreviation  
  validates_length_of :state, :maximum => 2, :on => :create, :message => "can only be two letters"
  validates_format_of :state, :with => /[A-Z]{2}/, :on => :create, :message => "must use capital letters"
  
  #validating phone
  validates_format_of :phone, :on => :create, :with => /^[+\/\-() 0-9]+$/, :if => :valid_phone?, :message => 'is an invalid phone number, only the following characters are allowed: 0-9/-()+'
  
  #validating evening session
  validates_presence_of :eveningsession, :on => :create, :message => ": Please make your selection: Will you attend the evening session?"
  validates_presence_of :guest, :on => :create, :if => Proc.new {|registrant| registrant.eveningsession?}, :message => ": If you are attending the evening session, will you bring a guest?"
  
  #validating lunch
  validates_presence_of :lunch, :on => :create, :message => ": Please make your selection. Will you attend the Trainee Lunch?"
  
  #validating bizperson
  validates_confirmation_of :bizpersonemail, :on => :create
  
  def valid_phone?
    error_message = 'is an invalid phone number, must contain at least 5 digits'
    if self.phone.length >= 5
      return true
    else
      self.errors.add(:phone, error_message) 
    end
  end
  
  
  
 
  
  private
    def capitalize_names
      self.firstname.capitalize!
      self.lastname.capitalize!
    end
    
    def capitalize_city
      self.city.capitalize!
    end
    
    def chop_title_whitespace
      self.title.strip!
    end
    
    def set_party_size
      if self.eveningsession? && self.guest?
        self.partysize = 2
      elsif self.eveningsession? && self.guest == 0
        self.partysize = 1
      else
        self.partysize = 0
      end
    end
    
    def set_fees
      if self.eveningsession? 
        case self.status
          when 'UK Faculty'
            self.fees = 50.00
          when 'Non-UK Faculty'
            self.fees = 50.00
          when 'Staff'
            self.fees = 25.00
          when 'Student'
            self.fees = 25.00
          when 'Post-doc'
            self.fees = 25.00
          end
      else
        self.fees = 0.00
      end
    end
end
