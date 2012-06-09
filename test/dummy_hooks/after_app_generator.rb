# Add our main menu override
copy_file "overrides/main_menu.rb", "app/overrides/main_menu.rb"

>>>>>>> 0c88c51... allow i18n for contents
# remove all stylesheets except core
%w(admin store).each do |ns|
  template "assets/javascripts/#{ns}/all.js",  "app/assets/javascripts/#{ns}/all.js",  :force => true
  template "assets/stylesheets/#{ns}/all.css", "app/assets/stylesheets/#{ns}/all.css", :force => true
end

# Fix sass load error by using the converted css file
template "assets/stylesheets/store/screen.css", "app/assets/stylesheets/store/screen.css"

# Enable forgery_protection since we need AUTH_TOKEN to be defined to avoid JS errors
gsub_file "config/environments/test.rb", "forgery_protection    = false", "forgery_protection = true"

template "initializers/spree_multi_lingual.rb", "config/initializers/spree_multi_lingual.rb"
