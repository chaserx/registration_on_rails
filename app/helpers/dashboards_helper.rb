module DashboardsHelper

  def hasFees(reg)
    if reg.fees > 0
      return "$,"
    else "No Fees,"
    end
    rescue "Unknown Fees,"
  end

  def hasEveningSession(reg)
    if reg.eveningsession == 1
      return "Evening Session,"
    else "No Evening Session,"
    end 
    rescue "Unknown Evening Session,"
  end
  
  def hasLunch(reg)
    if reg.lunch == 1
      return "Lunch"  
    else "No Lunch"
    end
    rescue "Unknown Lunch"
  end
  
  def singleOrCompany(reg)
    if reg.eveningsession == 1
      case
        when reg.partysize == 1
          return "Single for"
        when reg.partysize > 1
          return "Party of #{reg.partysize} for"
      end
    end
    rescue "Unknown Party Size for"
  end
end
