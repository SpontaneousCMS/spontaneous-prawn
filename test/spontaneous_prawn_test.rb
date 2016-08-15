require 'test_helper'

class SpontaneousPrawnTest < Minitest::Test
  def setup
    @site = setup_site()
    @page = Page.new(title: "Some kinda page")
  end

  def teardown
  end

  def test_that_it_has_a_version_number
    refute_nil ::SpontaneousPrawn::VERSION
  end

  def test_render_page
    output = @page.render(:pdf)
    p output
  end

  def site_root
    File.expand_path("../fixtures/test_com", __FILE__)
  end

  def setup_site
    require ::File.join(site_root, 'config/boot.rb')
    Spontaneous::Site.instance
  end
end
