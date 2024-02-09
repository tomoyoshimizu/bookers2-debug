module Scope
  extend ActiveSupport::Concern

  class_methods do

    def created_while(period)

      case period
      when "today" then
        where(created_at: Time.current.all_day)
      when "yesterday" then
        where(created_at: 1.day.ago.all_day)
      when "this_week" then
        where(created_at: 6.day.ago.beginning_of_day..Time.current.end_of_day)
      when "last_week" then
        where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day)
      else
        where(created_at: period)
      end

    end

  end

end