# TODO - DirtyFix rake 0.9+ : https://github.com/rails/rails/issues/6490
Spree::Content::Translation.class_eval do
  def link() read_attribute(:link) end
  def link=(l) write_attribute(:link, l) end
end