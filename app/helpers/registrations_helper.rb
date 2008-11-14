module RegistrationsHelper
  def going_esession?(arr)
    if arr.eveningsession == 0
      render :inline => "No"
    elsif arr.eveningsession == 1
      render :inline => "Yes"
    else
      render :inline => "?"
    end
  end
  
  def going_lunch?(arr)
    if arr.lunch == 0
      render :inline => "No"
    elsif arr.lunch == 1
      render :inline => "Yes"
    else
      render :inline => "?"
    end
  end
  
  def number_of_attendees
    return Registration.count
  end
  
  def number_of_attendees_for_lunch
    return Registration.find(:all, :conditions => "lunch = '1'").size
  end
  
  def number_of_attendees_for_dinner
    total = 0
    registrations = Registration.find(:all)
    registrations.each{|e| total += e.partysize}
    return total
  end

  
  
  def latest_attendee
    @registration = Registration.find(:last)
    
    return "#{@registration.last.firstname} #{@registration.last.lastname}<br />#{time_ago_in_words(@registration.last.created_at)} ago"
  end
  
  def format_phone(reg)
    ph = reg
    if ph.size == 10
      return "(#{ph[0..2]}) #{ph[3..5]} - #{ph[6..9]}"
    elsif ph.size == 5
      return "#{ph.first}-#{ph[1..4]}"
    elsif ph.size == 7
      return "#{ph[0..2]} - #{ph[3..6]}"
    else
      return ph
    end
    
  end
end
