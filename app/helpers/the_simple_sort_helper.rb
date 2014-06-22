module TheSimpleSortHelper
  def simple_sort_url field, params
    sort_type = :asc

    if params[:sort_column] == field.to_s
      sort_type = { desc: :asc, asc: :desc }[ params[:sort_type].to_sym ]
    end

    url_for params.merge(sort_column: field, sort_type: sort_type)
  end
end
