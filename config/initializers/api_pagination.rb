ApiPagination.configure do |config|
  # If you have more than one gem included, you can choose a paginator.
  # config.paginator = :kaminari # or :will_paginate

  # By default, this is set to 'Total'
  # config.total_header = 'X-Total'

  # By default, this is set to 'Per-Page'
  # config.per_page_header = 'X-Per-Page'

  # Optional: set this to add a header with the current page number.
  # config.page_header = 'X-Page'

  # Optional: what parameter should be used to set the page option
  # config.page_param = :page
  # or
  # config.page_param do |params|
  #   params[:page][:number]
  # end

  # Optional: what parameter should be used to set the per page option
  # config.per_page_param = :per_page
  # or
  # config.per_page_param do |params|
  #   params[:page][:size]
  # end

  # Optional: Include the total and last_page link header
  # By default, this is set to true
  # Note: When using kaminari, this prevents the count call to the database
  config.include_total = false

  # Recommend to set the max per page variable for Pagy
  # Pagy::VARS[:max_per_page] = 20
end
