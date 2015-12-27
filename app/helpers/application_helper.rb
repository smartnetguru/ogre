module ApplicationHelper
  def pretty_date_range(start, stop)
    dateformat =  "%b %d, %Y"
    return '' if start.nil? and stop.nil?
    return stop.end.strftime dateformat if start.nil?
    return start.strftime dateformat if stop.nil?
    return "#{start.strftime dateformat} - #{stop.strftime dateformat}"
  end
end
