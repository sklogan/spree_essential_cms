# Install spree's migrations
rake "spree:install:migrations"

# Mount the Spree::Core routes
insert_into_file File.join('config', 'routes.rb'), :after => "Application.routes.draw do\n" do
  "  # Mount Spree's routes\n  mount Spree::Core::Engine, :at => '/'\n"
end

# Install spree essentials, CMS & spree_multi_lingual
run 'bundle exec rails g spree_multi_lingual:install --yes'
run "bundle exec rails g spree_essentials:install"
run "bundle exec rails g spree_essentials:cms"
