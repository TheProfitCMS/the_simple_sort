require "the_simple_sort/version"

module TheSimpleSort
  class Engine < Rails::Engine; end

  module Base
    extend ActiveSupport::Concern

    included do
      scope :recent, ->(field = nil) { reorder("#{ field } DESC") if field }
      scope :old,    ->(field = nil) { reorder("#{ field } ASC")  if field }

      scope :simple_sort, ->(params, default_sort_field = nil){
        sort_column = params[:sort_column]
        sort_type   = params[:sort_type]

        return recent(default_sort_field) unless sort_column
        return recent(sort_column)        unless sort_type

        sort_type.downcase == 'asc' ? recent(sort_column) : old(sort_column)
      }
    end
  end
end
