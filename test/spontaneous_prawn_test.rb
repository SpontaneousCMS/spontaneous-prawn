require 'test_helper'

class SpontaneousPrawnTest < Minitest::Test
  def setup
    @site = setup_site()
    @page = Page.create(title: "Some kinda page")
    @page.image = "test/fixtures/image.jpg"
    @images = 3.times.map do |n|
      @page.images << Image.new(title: "Image #{n}")
    end
    @images.zip([
      "test/fixtures/yellowstone-national-park-1581900_640.jpg",
      "test/fixtures/zucchini-1513112_640.jpg",
      "test/fixtures/frogs-1517934_640.jpg"
    ]).each do |piece, path|
      piece.image = path
      piece.save
    end
    @page.save
  end

  def teardown
    Spontaneous::Publishing::Revision.delete_all(Content)
    Page.delete
  end

  def test_that_it_has_a_version_number
    refute_nil ::SpontaneousPrawn::VERSION
  end

  def test_render_page
    output = @page.render(:pdf)
    assert output.encoding == Encoding::BINARY
    expected = ::File.read("test/outputs/test_render_page.pdf", encoding: Encoding::BINARY)
    # So I can have a look at the result easily
    File.open("test_render_page.pdf", 'wb') { |f| f.write(output) }
    assert output == expected
  end

  def test_publish_page
    revision = 1
    @site.model.publish_all(revision)
    output_store = @site.output_store(:Memory)
    step = Spontaneous::Publishing::Steps::RenderRevision
    store = output_store.revision(revision).store
    transaction = Spontaneous::Publishing::Transaction.new(@site, 1, nil)

    @site.model.scope(revision, true) do
      step.call(transaction)
    end

    output = @page.output(:pdf)
    key = store.output_key(output, false)
    pdf = store.load_static(revision, key).read
    expected = ::File.read("test/outputs/test_render_page.pdf", encoding: Encoding::BINARY)
    assert pdf == expected
  end

  def site_root
    File.expand_path("../fixtures/test_com", __FILE__)
  end

  def setup_site
    require ::File.join(site_root, 'config/boot.rb')
    site = Spontaneous::Site.instance
    site.background_mode = :immediate
    site
  end
end
