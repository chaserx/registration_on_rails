# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def display_eventname
    return APP_CONFIG['name']
  end
  
  def display_eventdate
    return APP_CONFIG['dates']
  end
  
  def display_secretary
    return APP_CONFIG['secretary']
  end
  
  def display_reg_stop_date
    return APP_CONFIG['reg_stop_date']
  end
  
  def display_director
    return APP_CONFIG['director']
  end
  
  def display_director_address
    return APP_CONFIG['director_address']
  end
  
  def css_for(link)
    #controller.controller_name.downcase == link.downcase ? 'current' : 'plain'
    #credit ryan heath http://rpheath.com/posts/268-tabbed-navigation-tip-for-rails
    controller.action_name.downcase == link.downcase ? 'current' : 'plain'
  end
  
  def format_name(reg)
    return reg.title + " " + reg.firstname + " " + reg.lastname
  end
  
  def total_reg_fees
    total = 0
    registrations = Registration.find(:all)
    registrations.each{|e| total += e.fees}
    return total
  end
  
  def last_update
    lastRegistration = Registration.find(:last, :order => 'created_at ASC')
    return lastRegistration.created_at
  end
end
