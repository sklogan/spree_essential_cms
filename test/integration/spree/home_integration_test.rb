# encoding: utf-8

require 'test_helper'

class Spree::HomeIntegrationTest < SpreeEssentials::IntegrationCase

  setup do
    Spree::Page.destroy_all
    @images = Dir[File.expand_path("../../../../lib/tasks/sample", __FILE__) + "/*.jpg"]
  end

  should "not redirect to products when no homepage is present" do
    visit "/"
    assert_equal "/", current_path
  end

  context "an existing homepage" do

    setup do
      @home = Spree::Page.create(:title => "Home", :meta_title => "Welcome to our homepage!", :meta_description => 'Find all the latest trends', :path => "/")
      @home.contents.first.update_attributes(:body => "This is a test", :context => "main")
      @home.contents.create(:title => "Some might say...", :body => "This is another test", :context => "intro")
      @images.each { |image|
        image = File.open(image)
        @home.images.create(:attachment => image, :alt => "Sailing", :viewable => @home)
        image.close
      }
      visit "/"
    end

    should "have proper page title" do
      assert_title "Welcome to our homepage! - Spree Demo Site"
    end

    should "have proper contents" do
      within ".left .content-main" do
        assert_seen "Home", :within => "h1.title"
        assert_seen "This is a test", :within => "p"
      end
      within ".intro .content-main" do
        assert_seen "Some might say...", :within => "h1.title"
        assert_seen "This is another test", :within => "p"
      end
    end

    should "have a images in slideshow" do
      within "#content .slideshow" do
        @home.images.each do |img|
          assert has_xpath?("//img[@src='#{img.attachment.url(:slide)}']")
        end
      end
    end

    should 'have proper meta tags by language' do
      @home.update_attributes :meta_title_fr => "Bienvenue sur notre page d'accueil!", :meta_description_fr => "Retrouvez toutes les dernières nouveautés"

      %w(/ /en).each do |en_path|
        visit en_path
        assert_seen "Welcome to our homepage!"
        assert have_meta?(:description, 'Find all the latest trends')
      end

      visit '/fr'
      assert_seen "Bienvenue sur notre page d'accueil!"
      assert have_meta?(:description, "Retrouvez toutes les dernières nouveautés")
    end
  end

end
