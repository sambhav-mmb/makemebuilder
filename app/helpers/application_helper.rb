module ApplicationHelper

	def flash_key(key)
    case key
    when 'success'
      type_class = 'alert alert-success'
    when 'alert'
      type_class = 'alert alert-danger'
    when 'error'
      type_class = 'alert alert-danger'
    when 'notice'
      type_class = 'alert alert-info'
    else
    end
    type_class
  end

  def should_display_footer?
    return false if params[:controller].include?("devise") || params[:controller].include?("registrations")
    return true
  end

end