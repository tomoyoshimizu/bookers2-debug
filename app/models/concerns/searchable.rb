module Searchable
  extend ActiveSupport::Concern

  class_methods do

    def search(search_word, search_type)

      case self.to_s
      when "User" then
        target_column = "name"
      when "Book" then
        target_column = "title"
      end

      case search_type
      when "partial" then
        search_string = "%" + search_word + "%"
      when "perfect" then
        search_string = search_word
      when "forward" then
        search_string = search_word + "%"
      when "backward" then
        search_string = "%" + search_word
      end

      if search_word.present?
        where("#{target_column} LIKE ?", search_string)
      else
        all
      end

    end

  end

end