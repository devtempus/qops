module ApplicationHelper
  def twitterized_type(type)
    case type.to_sym
      when :alert
        'warning'
      when :error
        'danger'
      when :notice
        'info'
      when :success
        'success'
      else
        type.to_s
    end
  end
end
