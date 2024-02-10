module Scope
  extend ActiveSupport::Concern

  class_methods do

    def created_while(period)
      where(created_at: check_period(period))
    end

    def updated_while(period)
      where(updated_at: check_period(period))
    end

    private

    def check_period(period)
      case period
        when "today"     then Time.current.all_day
        when "yesterday" then 1.day.ago.all_day
        when "this_week" then 6.day.ago.beginning_of_day..Time.current.end_of_day
        when "last_week" then 2.week.ago.beginning_of_day..1.week.ago.end_of_day
        else period
      end
    end

  end

end