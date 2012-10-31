# Install spree's migrations
rake "spree:install:migrations"

# Copy
template "initializers/spree_user.rb", "config/initializers/spree_user.rb"

# Mount the Spree::Core routes
insert_into_file File.join('config', 'routes.rb'), :after => "Application.routes.draw do\n" do
  "  # Mount Spree's routes\n  mount Spree::Core::Engine, :at => '/'\n"
end

# Install spree essentials & CMS
run "bundle exec rails g spree_essentials:install"
run "bundle exec rails g spree_essentials:cms"
