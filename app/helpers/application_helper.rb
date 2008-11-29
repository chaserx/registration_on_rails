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
end
