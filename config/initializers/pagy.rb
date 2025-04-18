# Pagy initializer file
# Customize as needed
require 'pagy/extras/bootstrap'

# Set frontend
Pagy::DEFAULT[:frontend] = :bootstrap

# Number of items per page
Pagy::DEFAULT[:items] = 10

# Number of page links in the paginator
Pagy::DEFAULT[:size] = 10

# Load bootstrap Nav helper
require 'pagy/extras/bootstrap' 
