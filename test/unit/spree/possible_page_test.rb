require 'test_helper'

class Spree::PossiblePageTest < ActiveSupport::TestCase

  context '#matches?' do

    should 'return false on attachment url' do
    end

  end

  context '#image_root_path' do

    should 'returns begining of path until interpolation' do
      assert_equal '/spree/products', Spree::PossiblePage.new.image_root_path
    end

  end

end
