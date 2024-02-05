module Searchable
  extend ActiveSupport::Concern

  included do

    def self.search(search_word, search_type)

      case self.to_s
      when "User" then
        column_names = "name"
      when "Book" then
        column_names = "title"
      end

      case search_type
      when "部分一致" then
        search_string = "%#{search_word}%"
      when "完全一致" then
        search_string = search_word.to_s
      when "前方一致" then
        search_string = "#{search_word}%"
      when "後方一致" then
        search_string = "%#{search_word}"
      end

      if search_word.present?
        where("#{column_names} LIKE ?", search_string)
      else
        all
      end

    end

  end

end