require "the_simple_sort/version"

module TheSimpleSort
  class Engine < Rails::Engine; end

  module Base
    extend ActiveSupport::Concern

    included do
      scope :recent, ->(field = nil) { order("#{ field || :id } DESC") }
      scope :old,    ->(field = nil) { order("#{ field || :id } ASC")  }

      scope :simple_sort, ->(params, default_sort_field = :created_at){
        sort_column = params[:sort_column]
        sort_type   = params[:sort_type]

        return recent(default_sort_field) unless sort_column
        return recent(sort_column)        unless sort_type

        sort_type.downcase == 'asc' ? recent(sort_column) : old(sort_column)
      }
    end
  end
end
