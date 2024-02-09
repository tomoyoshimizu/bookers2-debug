module ApplicationHelper

  def helper_period(target)

    case target
    when "today" then
      Time.now.beginning_of_day..Time.now.end_of_day
    when "yesterday"then
      1.day.ago.beginning_of_day..1.day.ago.end_of_day
    when "this_week" then
      1.week.ago.beginning_of_day..Time.now.end_of_day
    when "last_week" then
      2.week.ago.beginning_of_day..8.day.ago.end_of_day
    end

  end

end
