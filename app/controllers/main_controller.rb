class MainController < UIViewController

  def viewDidLoad
    super

    # Sets a top of 0 to be below the navigation control
    self.edgesForExtendedLayout = UIRectEdgeNone

    rmq.stylesheet = MainStylesheet
    init_nav
    rmq(self.view).apply_style :root_view

    rmq.append(UILabel, :search_label)

    @query = rmq.append(UITextField, :query).focus.get

    rmq.append(UIButton, :submit_button).on(:touch) do |sender|
      search_for_images @query.text
    end
  end

  def init_nav
    self.title = "Lovely Cici"
  end

  def search_for_images(query)
    url = "https://www.flickr.com/photos/124333642@N04/sets/72157644523772453/"

    AFMotion::HTTP.get(url) do |result|
      if html = result.body
        images = html.scan(/src=\"(.+?\.jpg)\"/).map do |m|
          m.first
        end
        puts images
        puts "========================="
        puts "========================="
        puts "image empty? #{images.empty?}"
        puts "========================="
        puts "========================="
        rmq.animations.stop_spinner
      end
    end
  end

end
