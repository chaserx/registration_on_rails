# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def display_eventname
    return APP_CONFIG['name']
  end
  
  def display_eventdate
    return APP_CONFIG['dates']
  end
end
