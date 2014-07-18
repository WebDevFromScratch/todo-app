module ApplicationHelper
  def bootstrap_class_for flash_type
    case flash_type
      when "success"
        "alert-success"
      when "error"
        "alert-danger"
      when "alert"
        "alert-warning"
      when "notice"
        "alert-info"
      else
        flash_type.to_s
    end
  end

  def well_priority_class(obj)
    if obj.priority == 1
      "priority-low"
    elsif obj.priority == 2
      "priority-med"
    else
      "priority-high"
    end
  end

  def panel_priority_class(obj)
    if obj.priority == 1
      "panel-success"
    elsif obj.priority == 2
      "panel-warning"
    else
      "panel-danger"
    end    
  end

  def pretty_date(date)
    if date == Date.today
      "Today"
    elsif date == Date.today + 1
      "Tomorrow"
    elsif date == Date.today - 1
      "Yesterday"
    else
      date.strftime("%b %e, %Y")
    end
  end
end
