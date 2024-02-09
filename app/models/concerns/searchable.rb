module Searchable
  extend ActiveSupport::Concern

  class_methods do

    def search(search_word, search_type)

      target_column = case self.to_s
        when "User" then "name"
        when "Book" then "title"
      end

      search_string = case search_type
        when "partial"  then "%" + search_word + "%"
        when "perfect"  then search_word
        when "forward"  then search_word + "%"
        when "backward" then "%" + search_word
      end

      if search_word.present?
        where("#{target_column} LIKE ?", search_string)
      else
        all
      end

    end

  end

end