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
end
