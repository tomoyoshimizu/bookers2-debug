module UsersHelper

  def weekly_post_data(user)

    weekly_post_data = {}

    for count in 0..6 do
      if count != 0
        weekly_post_data["#{count}日前"] = user.post_count(count.day.ago.all_day)
      else
        weekly_post_data["今日"] = user.post_count("today")
      end
    end

    return weekly_post_data

  end

end
