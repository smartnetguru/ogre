module ApplicationHelper
  def best_fit_date(start, stop)
    if !start.nil?
      start
    elsif !stop.nil?
      stop
    else
      Time.at 0
    end
  end

  def pretty_date_range(start, stop)
    dateformat =  "%b %Y"
    return '' if start.nil? and stop.nil?
    return stop.end.strftime dateformat if start.nil?
    return start.strftime dateformat if stop.nil?
    return "#{start.strftime dateformat} - #{stop.strftime dateformat}"
  end
end
