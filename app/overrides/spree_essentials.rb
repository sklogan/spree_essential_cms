# Adds the Content button to the admin tabs
Deface::Override.new(:virtual_path  => "spree/admin/shared/_menu",
                     :name          => "spree_essential_admin_tabs",
                     :insert_bottom => "[data-hook='admin_tabs']",
                     :partial       => "spree/admin/shared/contents_tab",
                     :disabled      => false)

# Adds the contents menu. Inside the contents sub menu we ensure it's needed
Deface::Override.new(:virtual_path  => "spree/admin/shared/_sub_menu",
                     :name          => "spree_essential_contents_menu",
                     :insert_before => "erb[silent]:contains('content_for?(:sub_menu)')",
                     :partial       => "spree/admin/shared/contents_sub_menu",
                     :disabled      => false)